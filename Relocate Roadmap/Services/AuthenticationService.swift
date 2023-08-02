//
//  AuthenticationService.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.08.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {

    private let auth = Auth.auth()
    static let shared = AuthService()

    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {

        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }


    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))

        }

    }
}
