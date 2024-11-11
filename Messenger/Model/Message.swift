//
//  Message.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 05.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    var id: String {
        return messageId ?? UUID().uuidString
    }
    
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Date
    
    var user: User?
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isfromeCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timesTampString: String {
        return timestamp.timeTampString()
    }
      
}
