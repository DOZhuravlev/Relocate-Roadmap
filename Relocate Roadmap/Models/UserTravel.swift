//
//  RelocateUser.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import Foundation
import UIKit

struct UserTravel: Decodable {
    var userName: String
    var email: String
    var avatarStringURL: String
    var description: String
    var gender: String
    var age: String
    var id: String

    var representation: [String: Any] {
        var rep = ["username": userName]
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["gender"] = gender
        rep["age"] = age
        rep["email"] = email
        rep["uid"] = id
        return rep
    }
}

struct Test {
    var first: String?
    var second: String?
}
