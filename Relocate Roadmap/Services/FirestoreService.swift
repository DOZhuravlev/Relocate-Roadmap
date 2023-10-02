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

    func getUserData(user: User, completion: @escaping (Result<UserApp, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let userApp = UserApp(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToUserApp))
                    return
                }
                completion(.success(userApp))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }

    }

    func saveProfileWith(id: String, email: String, userName: String?, avatarImageString: String?, description: String?, gender: String?, completion: @escaping (Result<UserApp, Error>) -> Void) {

        guard Validators.isFilled(userName: userName, description: description, gender: gender) else { completion(.failure(UserError.notFilled))
            return
        }

        let userApp = UserApp(userName: userName!, email: email, avatarStringURL: "NO", description: description!, gender: gender!, id: id)

        usersRef.document(userApp.id).setData(userApp.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(userApp))
            }


        }
    }

}
