//
//  ChatService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 06.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


struct ChatService {
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let chatPartnerUID = chatPartner.id
        
        let currentUserRef = FirestoreConstants.messagesCollection
            .document(currentUID)
            .collection(chatPartnerUID)
            .document()
        
        let chatPartnerRef = FirestoreConstants.messagesCollection
            .document(chatPartnerUID)
            .collection(currentUID)

        let messageID = currentUserRef.documentID
        
        let message = Message(
            messageId: messageID,
            fromId: currentUID,
            toId: chatPartnerUID,
            messageText: messageText,
            timestamp:  Date()
        )

        guard let messageData = try? Firestore.Encoder().encode(message) else { return }

        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageID).setData(messageData)
    }
    
    func observeMessages(completion: @escaping ( [Message]) -> Void ) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let chatPartnerUID = chatPartner.id
        let query = FirestoreConstants.messagesCollection
            .document(currentUID)
            .collection(chatPartnerUID)
            .order(by: "timestamp", descending: false)

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter( { $0.type == .added } ) else { return }
            var messages = changes.compactMap( { try? $0.document.data(as: Message.self) } )
            for (index, message) in messages.enumerated() where !message.isfromeCurrentUser {
                messages[index].user = chatPartner
            }
            completion(messages)
        }
    }
}
