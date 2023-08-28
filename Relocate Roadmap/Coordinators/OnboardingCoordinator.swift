//
//  OnboardingCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.08.2023.
//

import UIKit

class OnboardingCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    private let moduleFactory = ModuleFactory()
    private var testData = Test(first: nil, second: nil)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showOnboardingModule()
    }

    private func showOnboardingModule() {
        let controller = moduleFactory.createEnterOnboardingModule()

        controller.completionHandler = { [weak self] value in
            self?.testData.first = value
        }

        navigationController.pushViewController(controller, animated: true)
    }


}
