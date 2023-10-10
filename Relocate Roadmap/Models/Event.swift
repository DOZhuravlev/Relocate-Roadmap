//
//  Event.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 03.10.2023.
//

import Foundation

struct Event {
    var description: String
    var date: String
    var category: String
    var id: String
    //var users: [UserApp]


    var representation: [String: Any] {
        var rep = ["description": description]
        rep["date"] = date
        rep["category"] = category
        rep["uid"] = id
        return rep
    }
}



