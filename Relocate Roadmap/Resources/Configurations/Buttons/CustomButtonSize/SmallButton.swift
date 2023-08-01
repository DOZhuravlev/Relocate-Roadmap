//
//  SmallButton.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 31.07.2023.
//

import UIKit

public struct SmallButtonSize: CustomButtonSize {
    var buttonHeight: CGFloat = 30
    var buttonWidth: CGFloat = 100
}

extension CustomButtonSize where Self == SmallButtonSize {
    static var small: CustomButtonSize { SmallButtonSize() }
}
