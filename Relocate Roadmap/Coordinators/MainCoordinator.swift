//
//  MainCoordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 31.08.2023.
//

import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showTabBarModule()
    }

    private func showTabBarModule() {
        let tabBarController = UITabBarController()

        let eventsNavigationController = UINavigationController()
        let eventsCoordinator = EventsCoordinator(navigationController: eventsNavigationController)
        eventsCoordinator.flowCompletionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }
        eventsCoordinator.start()
        eventsNavigationController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "house"), tag: 0)

        let mapNavigationController = UINavigationController()
        let mapCoordinator = MapCoordinator(navigationController: mapNavigationController)
        mapCoordinator.flowCompletionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }
        mapCoordinator.start()
        mapNavigationController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "iphone.homebutton.radiowaves.left.and.right.circle"), tag: 1)

        tabBarController.viewControllers = [eventsNavigationController, mapNavigationController]
        navigationController.pushViewController(tabBarController, animated: true)

    }


}
