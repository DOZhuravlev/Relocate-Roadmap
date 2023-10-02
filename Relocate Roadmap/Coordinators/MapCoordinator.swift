//
//  MapCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 31.08.2023.
//

import UIKit

class MapCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showModule()
    }

    private func showModule() {

        let controller = LoginViewController()
        navigationController.pushViewController(controller, animated: true)
    }


}
