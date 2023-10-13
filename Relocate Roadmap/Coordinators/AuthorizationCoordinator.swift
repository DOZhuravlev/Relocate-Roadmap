//
//  AuthorizationCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.10.2023.
//

import UIKit
import FirebaseAuth

class AuthorizationCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?
    var user: User?

    private let authFactory = AuthorizationFactory()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showRegistrationModule()
        //  IF ELSE
    }

    private func showLoginModule() {
        let controller = authFactory.createLoginModule(coordinator: self)
        controller.completionHandler = { [weak self] _ in
            guard let self else { return }
            self.showRegistrationModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    func showRegistrationModule() {
        let controller = authFactory.createRegistrationModule(coordinator: self)
        controller.completionHandler = { [weak self] value in
            guard let self else { return }
            self.user = value
            self.showSetupProfileModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    func showSetupProfileModule() {
        let controller = authFactory.createSetupProfileModule(coordinator: self, currentUser: user!)
        controller.completionHandler = { [weak self] value in
            guard let self else { return }
            self.flowCompletionHandler?()
        }
        navigationController.pushViewController(controller, animated: true)
    }

}
