//
//  Coordinator.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 16.08.2023.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject {

    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: CoordinatorHandler? { get set }

    func start()
}
