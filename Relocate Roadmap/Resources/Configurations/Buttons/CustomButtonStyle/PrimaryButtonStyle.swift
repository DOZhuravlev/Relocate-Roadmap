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
    let backgroundColor: UIColor? = UIColor(red: 0, green: 0.81, blue: 0.79, alpha: 1)
    let titleColor: UIColor = .white
    let tintColor: UIColor = .white
    let font: UIFont = CustomFonts.PoppinsBold.font(size: 16) ?? UIFont.systemFont(ofSize: 16)
}

struct PrimaryTypePressedConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor? = .white
    let titleColor: UIColor = .label
    let tintColor: UIColor = .red
    let font: UIFont = CustomFonts.PoppinsBold.font(size: 16) ?? UIFont.systemFont(ofSize: 16)
}

extension CustomButtonType where Self == PrimaryButtonType {
    static var primary: CustomButtonType { PrimaryButtonType() }
}

