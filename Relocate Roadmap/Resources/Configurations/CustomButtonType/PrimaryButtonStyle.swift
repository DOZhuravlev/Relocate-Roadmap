//
//  PrimaryButtonStyle.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 26.07.2023.
//

import UIKit

struct PrimaryButtonType: CustomButtonType {
    var standard: CustomButtonConfiguration = PrimaryTypeStandardConfiguration()

    var pressed: CustomButtonConfiguration = PrimaryTypePressedConfiguration()

}


struct PrimaryTypeStandardConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor = .systemGreen
    let titleColor: UIColor = .label
    let tintColor: UIColor = .black
}


struct PrimaryTypePressedConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor = .white
    let titleColor: UIColor = .label
    let tintColor: UIColor = .red
}

extension CustomButtonType where Self == PrimaryButtonType {
    static var primary: CustomButtonType { PrimaryButtonType() }
}


// PrimaryStyle - HelpStyle - SearchStyle - 3 файла будет разных кнопок(в каждом свои состяния)

