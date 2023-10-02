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
    case cannotGetUserInfo
    case cannotUnwrapToUserApp
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Не выбрали фотографию", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Невозможно загрузить User из FireBase", comment: "")
        case .cannotUnwrapToUserApp:
            return NSLocalizedString("Невозможно конвертировать UserApp из User", comment: "")
        }
    }
}
