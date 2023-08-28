//
//  AppCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 16.08.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var flowCompletionHandler: CoordinatorHandler?
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showOnboardingScreen()
    }

    func showOnboardingScreen() {
        let profileRegistrationViewModel = ProfileRegistrationViewModel()
        let profileRegistrationViewController = ProfileRegistrationViewController(viewModel: profileRegistrationViewModel, coordinator: self)
        navigationController.pushViewController(profileRegistrationViewController, animated: true)
    }


}
