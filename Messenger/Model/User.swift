//
//  User.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 30.10.2024.
//

import SwiftUI

struct User: Identifiable, Codable, Hashable {
    var id = NSUUID().uuidString
    let fullName: String
    let email: String
    let profileImageUrl: String?
}

extension User {
    static let mockUser: User = .init(
        fullName: "Hakob Ghlijyan",
        email: "hakob@ghlijyan.com",
        profileImageUrl: "hakob"
    )
}
