//
//  RelocateUser.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import Foundation
import UIKit
import FirebaseFirestore

struct UserApp: Decodable {
    var userName: String
    var email: String
    var avatarStringURL: String
    var description: String
    var gender: String
    var id: String

    init(userName: String, email: String, avatarStringURL: String, description: String, gender: String, id: String) {
        self.userName = userName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.id = id
    }

    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let username = data["username"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
                let description = data["description"] as? String,
                let gender = data["gender"] as? String,
                let email = data["email"] as? String,
                let id = data["uid"] as? String else { return nil }

        self.userName = username
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.id = id
    }

    var representation: [String: Any] {
        var rep = ["username": userName]
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["gender"] = gender
        rep["email"] = email
        rep["uid"] = id
        return rep
    }
}

struct Test {
    var first: String?
    var second: String?
    var three: String?
    var four: String?
    var Five: String?
}
