//
//  AppCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 16.08.2023.
//

import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    var flowCompletionHandler: CoordinatorHandler?
    var navigationController: UINavigationController

    private var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        if let user = Auth.auth().currentUser {
            FirestoreService.shared.getUserData(user: user) { result in
                switch result {
                case .success(_):
                    self.showMainFlow()
                case .failure(_):
                    self.showOnboardingFlow()
                }
            }
        } else {
            showOnboardingFlow()
        }
    }

    private func showOnboardingFlow() {

        let onboardingCoordinator = CoordinatorFactory().createOnboardingCoordinator(navigationController: navigationController)
        childCoordinators.append(onboardingCoordinator)

        onboardingCoordinator.flowCompletionHandler = { [weak self] in
            self?.showMainFlow()
        }

        onboardingCoordinator.start()

    }

    private func showMainFlow() {

        let loginCoordinator = AuthorizationCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)

        loginCoordinator.flowCompletionHandler = { [weak self] in
            self?.showMainFlow()
        }

        loginCoordinator.start()

    }


    // MVVM
    //    func showOnboardingScreen() {
    //        let profileRegistrationViewModel = ProfileRegistrationViewModel()
    //        let profileRegistrationViewController = ProfileRegistrationViewController(viewModel: profileRegistrationViewModel, coordinator: self)
    //        navigationController.pushViewController(profileRegistrationViewController, animated: true)
    //    }


}
