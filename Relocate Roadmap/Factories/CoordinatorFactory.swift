//
//  CoordinatorFactory.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 29.08.2023.
//

import Foundation
import UIKit

class CoordinatorFactory {
    func createOnboardingCoordinator(navigationController: UINavigationController) -> OnboardingCoordinator {
        OnboardingCoordinator(navigationController: navigationController)
    }
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }
    func createAuthorizationCoordinator(navigationController: UINavigationController) -> AuthorizationCoordinator {
        AuthorizationCoordinator(navigationController: navigationController)
    }



}
