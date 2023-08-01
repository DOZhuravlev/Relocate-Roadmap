//
//  MediumButton.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 26.07.2023.
//

import UIKit

public struct MediumButtonSize: CustomButtonSize {
    var buttonHeight: CGFloat = 40
    var buttonWidth: CGFloat = 200
}

extension CustomButtonSize where Self == MediumButtonSize {
    static var medium: CustomButtonSize { MediumButtonSize() }
}
