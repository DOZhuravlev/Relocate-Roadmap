//
//  Fonts.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 26.07.2023.
//

import UIKit

enum CustomFonts: String {
    case RobotoRegular = "Roboto-Regular"
    case MontserratBold = "Montserrat-Bold"
    case PoppinsBold = "Poppins-Bold"
    case MontserratRegular = "Montserrat-Regular"
    case RobotoMedium = "Roboto-Medium"
    case MontserratSemiBold = "Montserrat-SemiBold"

    func font(size: CGFloat) -> UIFont? {
        return UIFont(name: self.rawValue, size: size)
    }
}
