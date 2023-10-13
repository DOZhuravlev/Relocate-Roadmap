//
//  LoginViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 13.10.2023.
//

import Foundation

protocol LoginViewModelProtocol: AnyObject {
    var login: String { get set }
    var password: String { get set }
    func authorization(findUserCompletion: @escaping (Bool) -> Void, failureCompletion: @escaping (Error) -> Void)
}

final class LoginViewModel: LoginViewModelProtocol {

    var login: String = ""
    var password: String = ""

    func authorization(findUserCompletion: @escaping (Bool) -> Void, failureCompletion: @escaping (Error) -> Void) {
        AuthService.shared.login(email: login, password: password) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(_):
                        findUserCompletion(true)

                    case .failure(_):
                        findUserCompletion(false)
                    }
                }
                print("\(user.email ?? "")")
            case .failure(let error):
                print(error)
                failureCompletion(error)
            }
        }
    }
}
