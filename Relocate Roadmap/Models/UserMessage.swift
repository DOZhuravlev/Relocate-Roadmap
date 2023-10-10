//
//  UserMessage.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 06.10.2023.
//

import UIKit
import Foundation
import FirebaseFirestore
import MessageKit

struct Sender: SenderType {
    public let senderId: String
    public let displayName: String
}

struct UserMessage: Hashable, MessageType {

    var sender: SenderType
    var messageId: String {
        return id ?? UUID().uuidString
    }
    var kind: MessageKind {
        return .text(content)
    }
    let content: String
    var sentDate: Date
    let id: String?

    init(user: UserApp, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.userName)
        sentDate = Date()
        id = nil
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil}
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }

        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderName)
        self.content = content

    }

    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
            ]
        return rep
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    static func == (lhs: UserMessage, rhs: UserMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }

}

extension UserMessage: Comparable {
    static func < (lhs: UserMessage, rhs: UserMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
}