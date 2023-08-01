//
//  SecondaryButtonStyle.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 31.07.2023.
//

import UIKit

struct SecondaryButtonType: CustomButtonType {
    var standard: CustomButtonConfiguration = SecondaryTypeStandardConfiguration()

    var pressed: CustomButtonConfiguration = SecondaryTypePressedConfiguration()

}

struct SecondaryTypeStandardConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor? = Colors.backgroundWhite
    let titleColor: UIColor = .black
    let tintColor: UIColor = .white
    let font: UIFont = CustomFonts.PoppinsBold.font(size: 16) ?? UIFont.systemFont(ofSize: 16)
}

struct SecondaryTypePressedConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor? = .white
    let titleColor: UIColor = .label
    let tintColor: UIColor = .red
    let font: UIFont = CustomFonts.PoppinsBold.font(size: 16) ?? UIFont.systemFont(ofSize: 16)
}

extension CustomButtonType where Self == SecondaryButtonType {
    static var secondary: CustomButtonType { SecondaryButtonType() }
}
