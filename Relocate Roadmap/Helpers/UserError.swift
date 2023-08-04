//
//  UserError.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполнете все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Не выбрали фотографию", comment: "")

        }
    }
}
