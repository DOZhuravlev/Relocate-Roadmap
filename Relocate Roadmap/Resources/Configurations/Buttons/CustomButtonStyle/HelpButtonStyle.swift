//
//  HelpButtonStyle.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 26.07.2023.
//

import Foundation
import UIKit

struct HelpButtonType: CustomButtonType {
    var standard: CustomButtonConfiguration = HelpTypeStandardConfiguration()
    var pressed: CustomButtonConfiguration = HelpTypePressedConfiguration()
}

struct HelpTypeStandardConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor? = nil
    let titleColor: UIColor = Colors.textGreenButton
    let tintColor: UIColor = .white
    let font: UIFont = CustomFonts.RobotoRegular.font(size: 12) ?? UIFont.systemFont(ofSize: 14)
}

struct HelpTypePressedConfiguration: CustomButtonConfiguration {
    let backgroundColor: UIColor? = .white
    let titleColor: UIColor = .label
    let tintColor: UIColor = .red
    let font: UIFont = CustomFonts.RobotoRegular.font(size: 12) ?? UIFont.systemFont(ofSize: 14)
}

extension CustomButtonType where Self == HelpButtonType {
    static var help: CustomButtonType { HelpButtonType() }
}
