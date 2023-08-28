//
//  ModuleFactory.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.08.2023.
//

import Foundation

class ModuleFactory {

    func createWelcomeModule() -> WelcomeViewController {
        WelcomeViewController()
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
