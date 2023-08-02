//
//  AuthError.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.08.2023.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполнете все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Неверный формат почты", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка на сервере", comment: "")
        }
    }
}
