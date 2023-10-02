//
//  TutorialViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 25.09.2023.
//

import Foundation
import UIKit

protocol TutorialViewModelProtocol {

    var backgroundImage: UIImage? { get }
    var welcomeLabelText: String { get }
    var descriptionLabelText: String { get }

}

final class TutorialViewModel: TutorialViewModelProtocol {

    var backgroundImage: UIImage? {
        return UIImage(named: "onboarding1")
    }

    var welcomeLabelText: String {
        return "Добро пожаловать!"
    }

    var descriptionLabelText: String {
        return "Приложение поможет вам релоцироваться в другие страны и легко адаптироваться в новой среде."
    }





}