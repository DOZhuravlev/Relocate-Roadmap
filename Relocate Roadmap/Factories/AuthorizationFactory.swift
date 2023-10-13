//
//  AuthorizationFactory.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 13.10.2023.
//

import Foundation
import FirebaseAuth

final class AuthorizationFactory {
    func createLoginModule(coordinator: Coordinator) -> LoginViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel, coordinator: coordinator)
    }

    func createRegistrationModule(coordinator: Coordinator) -> RegistrationViewController {
        let viewModel = RegistrationViewModel()
        return RegistrationViewController(viewModel: viewModel, coordinator: coordinator)
    }

    func createSetupProfileModule(coordinator: Coordinator, currentUser: User) -> SetupProfileRegistrationViewController {
        let viewModel = SetupProfileRegistrationViewModel(currentUser: currentUser)
        return SetupProfileRegistrationViewController(viewModel: viewModel, coordinator: coordinator)
    }
}
