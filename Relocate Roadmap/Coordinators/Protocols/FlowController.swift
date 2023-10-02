//
//  FlowController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.08.2023.
//

import Foundation

protocol FlowController {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
