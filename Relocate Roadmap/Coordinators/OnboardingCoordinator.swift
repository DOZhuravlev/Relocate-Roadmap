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
    private var testData = Test(first: nil, second: nil, three: nil, four: nil, Five: nil)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showWelcomeModule()
    }

    private func showWelcomeModule() {
        let controller = moduleFactory.createWelcomeModule(coordinator: self)
        controller.completionHandler = { [weak self] value in
            self?.testData.first = value
            self?.showTutorialModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showTutorialModule() {
        let controller = moduleFactory.createTutorialModule()
        controller.completionHandler = { [weak self] value in
            self?.testData.second = value
            self?.showFeaturesModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showFeaturesModule() {
        let controller = moduleFactory.createFeaturesModule()
        controller.completionHandler = { [weak self] value in
            self?.testData.second = value
            self?.showPermissionsModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showPermissionsModule() {
        let controller = moduleFactory.createPermissionsModule()
        controller.completionHandler = { [weak self] value in
            self?.testData.second = value
            self?.showDoneModule()
        }
        navigationController.pushViewController(controller, animated: true)
    }

    private func showDoneModule() {
        let controller = moduleFactory.createDoneModule()
        controller.completionHandler = { [weak self] value in
            self?.testData.second = value
            self?.flowCompletionHandler?()
        }
        navigationController.pushViewController(controller, animated: true)
    }

}
