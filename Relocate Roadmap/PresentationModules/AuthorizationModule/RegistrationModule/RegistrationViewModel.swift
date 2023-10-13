//
//  RegistrationViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 14.10.2023.
//

import Foundation
import FirebaseAuth

protocol RegistrationViewModelProtocol: AnyObject {
    var login: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }

    func registration(completion: @escaping (Result<User, Error>) -> Void)
}

final class RegistrationViewModel: RegistrationViewModelProtocol {

    var login: String = ""
    var password: String = ""
    var confirmPassword: String = ""


    func registration(completion: @escaping (Result<User, Error>) -> Void) {
        AuthService.shared.register(email: login,
                                    password: password,
                                    confirmPassword: confirmPassword) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
                //self.showAlert(title: "Регистрация", message: "Вы зарегистрированы!")

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
