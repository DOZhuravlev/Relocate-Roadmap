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

    private var userRef: CollectionReference {
        return db.collection("users")
    }

    func saveProfileWith(id: String, email: String, userName: String, avatarImageString: String, description: String, gender: String, age: String, completion: @escaping (Result<UserTravel, Error>) -> Void) {

        guard Validators.isFilled(userName: userName, description: description, gender: gender, age: age) else { completion(.failure(UserError.notFilled))
            return
        }

        let userTravel = UserTravel(userName: userName, email: email, avatarStringURL: avatarImageString, description: description, gender: gender, age: age, id: id)

        userRef.document(userTravel.id).setData(userTravel.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(userTravel))
            }


        }
    }

}
