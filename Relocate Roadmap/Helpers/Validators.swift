//
//  Validators.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 02.08.2023.
//

import Foundation

final class Validators {

    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
              let confirmPassword = confirmPassword,
              let email = email,
              password != "",
              confirmPassword != "",
              email != "" else {
            return false
        }
        return true
    }

    static func isFilled(userName: String?, description: String?, gender: String?, age: String?) -> Bool {
        guard let userName = userName,
              let description = description,
              let gender = gender,
              let age = age,
              userName != "",
              description != "",
              gender != "",
              age != "" else {
            return false
        }
        return true
    }

    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
    static func isSimpleEmail(email: String) -> Bool {
        let emailRegEx = "^.+@+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
}
