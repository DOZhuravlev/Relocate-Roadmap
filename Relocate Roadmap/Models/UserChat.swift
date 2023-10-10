//
//  UserChat.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 06.10.2023.
//

import Foundation
import FirebaseFirestore

struct UserChat: Decodable, Equatable {
    var friendUsername: String
    var friendAvatarStringURL: String
    var lastMessageContent: String
    var friendId: String
    //var users: [UserApp]


    var representation: [String: Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendAvatarStringURL"] = friendAvatarStringURL
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId
        return rep
    }

    init(friendUsername: String, friendAvatarStringURL: String, lastMessageContent: String, friendId: String) {
        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        print("INIT  INIT INIT INIT INIT INIT INIT INIT INIT INIT INIT")
        guard let friendUsername = data["friendUsername"] as? String,
              let friendAvatarStringURL = data["friendAvatarStringURL"] as? String,
              let lastMessageContent = data["lastMessage"] as? String,
              let friendId = data["friendId"] as? String else { return nil }

        self.friendUsername = friendUsername
        self.friendAvatarStringURL = friendAvatarStringURL
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
}
