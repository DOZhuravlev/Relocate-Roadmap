//
//  AuthorizationCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.10.2023.
//

import UIKit

class AuthorizationCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showModule()
    }

    private func showModule() {

        let controller = AuthorizationViewController()
        navigationController.pushViewController(controller, animated: true)
    }

}
