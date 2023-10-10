//
//  FirestoreService.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 03.08.2023.
//

import Firebase
import FirebaseFirestore

final class FirestoreService {

    static let shared = FirestoreService()

    let db = Firestore.firestore()

    private var usersRef: CollectionReference {
        return db.collection("users")
    }

    private var eventsRef: CollectionReference {
        return db.collection("events")
    }

    private var chatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "chats"].joined(separator: "/"))
    }


    var currentUser: UserApp!



    func getUserData(user: User, completion: @escaping (Result<UserApp, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let userApp = UserApp(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToUserApp))
                    return
                }
                self.currentUser = userApp
                print("ЗАПРОСИЛ ЮЗЕРАААААААААААА - \(userApp)")
                completion(.success(userApp))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }

    }

    func saveProfileWith(id: String, email: String, userName: String?, avatarImage: UIImage?, description: String?, gender: String?, completion: @escaping (Result<UserApp, Error>) -> Void) {

        guard Validators.isFilled(userName: userName, description: description, gender: gender) else { completion(.failure(UserError.notFilled))
            return
        }

        guard avatarImage != UIImage(named: "2") else {
            completion(.failure(UserError.photoNotExist))
            return
        }

        var userApp = UserApp(userName: userName!, email: email, avatarStringURL: "NO", description: description!, gender: gender!, id: id)

        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {

            case .success(let url):
                userApp.avatarStringURL = url.absoluteString
                self.usersRef.document(userApp.id).setData(userApp.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(userApp))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func createEvent(id: String, description: String?, completion: @escaping (Result<Event, Error>) -> Void) {

        var event = Event(description: description!, date: "01.01.1000", category: "Sport", id: id)

        eventsRef.document(event.id).setData(event.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(event))
            }

        }
    }


    func createChatWithUser(message: String, receiver: UserApp, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = db.collection(["users", receiver.id, "chats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")

        let message = UserMessage(user: currentUser, content: message)
        let chat = UserChat(friendUsername: currentUser.userName,
                            friendAvatarStringURL: currentUser.avatarStringURL,
                            lastMessageContent: message.content,
                            friendId: currentUser.id)

        reference.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.addDocument(data: message.representation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }


    func deleteChat(chat: UserChat, completion: @escaping (Result<Void, Error>) -> Void) {
        chatsRef.document(chat.friendId).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            self.deleteMessages(chat: chat, completion: completion)
        }
    }

    func deleteMessages(chat: UserChat, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = chatsRef.document(chat.friendId).collection("messages")
        getChatMessages(chat: chat) { result in
            switch result {
            case .success(let messages):
                for message in messages {
                    guard let documentId = message.id else { return }
                    let messageRef = reference.document(documentId)
                    messageRef.delete { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getChatMessages(chat: UserChat, completion: @escaping (Result<[UserMessage], Error>) -> Void) {
        let reference = chatsRef.document(chat.friendId).collection("messages")
        var messages = [UserMessage]()
        reference.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            for document in querySnapshot!.documents {
                guard let message = UserMessage(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }

    func sendMessage(chat: UserChat, message: UserMessage, completion: @escaping (Result<Void, Error>) -> Void) {
        let friendRef = usersRef.document(chat.friendId).collection("chats").document(currentUser.id)
        //добрались до чата с кем общаемся

        let friendMessageRef = friendRef.collection("messages")
        // сообщения в чате друга

        let myMessageRef = usersRef.document(currentUser.id).collection("chats").document(chat.friendId).collection("messages")
        // сообщения свои

        let chatForFriend = UserChat(friendUsername: currentUser.userName,
                                     friendAvatarStringURL: currentUser.avatarStringURL,
                                     lastMessageContent: message.content,
                                     friendId: currentUser.id)
        // зеркалим данные

        friendRef.setData(chatForFriend.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            } // создаем чат друга
            friendMessageRef.addDocument(data: message.representation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                } // добавляем в чат другу новое сообщение
                myMessageRef.addDocument(data: message.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    } // добавляем себе сообщение
                    completion(.success(Void()))

                }


            }

        }
    }
}
