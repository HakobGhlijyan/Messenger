//
//  User.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 30.10.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct User: Identifiable, Codable, Hashable {    
    @DocumentID var uid: String?
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
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
