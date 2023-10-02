//
//  ModuleFactory.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.08.2023.
//

import Foundation
import UIKit

class ModuleFactory {

    func createWelcomeModule(coordinator: Coordinator) -> WelcomeViewController {
        let viewModel = WelcomeViewModel()
        return WelcomeViewController(viewModel: viewModel, coordinator: coordinator)
    }

    func createTutorialModule() -> TutorialViewController {
        TutorialViewController()
    }

    func createFeaturesModule() -> FeaturesViewController {
        FeaturesViewController()
    }

    func createPermissionsModule() -> PermissionsViewController {
        PermissionsViewController()
    }

    func createDoneModule() -> DoneViewController {
        DoneViewController()
    }

}
