//
//  ListenerService.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.10.2023.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    static let shared = ListenerService()

    private let db = Firestore.firestore()

    private var userRef: CollectionReference {
        return db.collection("users")
    }

    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }

    func usersObserve(users: [UserApp], completion: @escaping (Result<[UserApp], Error>) -> Void) -> ListenerRegistration? {
        var users = users
        let usersListener = userRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }

            snapshot.documentChanges.forEach { diff in
                guard let userApp = UserApp(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !users.contains(where: { $0 == userApp }) else { return }
                    guard userApp.id != self.currentUserId else { return }
                    users.append(userApp)
                case .modified:
                    guard let index = users.firstIndex(of: userApp) else { return }
                    users[index] = userApp
                case .removed:
                    guard let index = users.firstIndex(of: userApp) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }

    func chatsObserve(chats: [UserChat], completion: @escaping (Result<[UserChat], Error>) -> Void) -> ListenerRegistration? {
        var chats = chats
        let chatsRef = db.collection(["users", self.currentUserId, "chats"].joined(separator: "/"))
        let collectionPath = chatsRef.path
        print("chatsRef chatsRef chatsRef chatsRef - \(collectionPath)")
        let chatsListener = chatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            print("currentUserId - \(self.currentUserId)")
            print("SNAAAAAAAAAPPPPPPPPPPPPPP\(snapshot)")

            if snapshot.isEmpty {
                print("Снимок пуст")
            } else {
                print("Снимок содержит данные")
                // Ваш код для обработки данных из снимка
            }


            snapshot.documentChanges.forEach { diff in
                print("ШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШШ")
                guard let chat = UserChat(document: diff.document) else { return }
                print("CCCCCCCCCCCCCC-\(chat)")
                switch diff.type {
                case .added:
                    //guard !chats.contains(where: { $0 == chat }) else { return }
                    guard !chats.contains(chat) else { return }
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats.remove(at: index)
                }
            }
            completion(.success(chats))
            print("/nLLLLLLLLLLLLLLLLLL - \(chats)")
        }
        return chatsListener
    }

    func messagesObserve(chat: UserChat, completion: @escaping (Result<UserMessage, Error>) -> Void) -> ListenerRegistration? {
        let ref = userRef.document(currentUserId).collection("chats").document(chat.friendId).collection("messages")
        let messagesListener = ref.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }

            snapshot.documentChanges.forEach { diff in
                guard let message = UserMessage(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    completion(.success(message))
                case .modified:
                    break
                case .removed:
                    break
                }
            }

        }
        return messagesListener


    }
}
