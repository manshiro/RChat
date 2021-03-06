//
//  User.swift
//  RChat
//
//  Created by Andrew Morgan on 23/11/2020.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var _id = UUID().uuidString
    @objc dynamic var partition = "" // "user=_id"
    @objc dynamic var userName = ""
    @objc dynamic var userPreferences: UserPreferences?
    @objc dynamic var lastSeenAt: Date?
    let conversations = List<Conversation>()
    @objc dynamic var presence = "Off-Line"

    var isProfileSet: Bool { !(userPreferences?.isEmpty ?? true) }
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }

    override static func primaryKey() -> String? {
        return "_id"
    }
}

extension User: Identifiable {
    var id: String { _id }
}

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}
