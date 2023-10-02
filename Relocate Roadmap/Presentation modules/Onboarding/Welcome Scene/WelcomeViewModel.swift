//
//  WelcomeViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 01.09.2023.
//

import Foundation
import UIKit

protocol WelcomeViewModelProtocol {

    var backgroundImage: UIImage? { get }
    var welcomeLabelText: String { get }
    var descriptionLabelText: String { get }

}

final class WelcomeViewModel: WelcomeViewModelProtocol {

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


