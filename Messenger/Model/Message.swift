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
    //ID for message
    @DocumentID var messageId: String?
    var id: String {
        return messageId ?? UUID().uuidString
    }
    
    // id users - send or my
    let fromId: String
    let toId: String
    
    //
    let messageText: String
    let timestamp: Date                     
    
    //User
    var user: User?
    
    // logic chtob ponyat s kem user nachal obshenie
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    // logic for current user , esli v masive soobsheniy po id message budet raven current user , to budet sinim...
    var isfromeCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
}
