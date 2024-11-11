//
//  InboxService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 06.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class InboxService {
    @Published var docChanges: [DocumentChange] = []
    
    func observeRecentMessages() {
        guard let uid = Auth.auth().currentUser?.uid else { return }    //user id
        
        let query = FirestoreConstants
            .messagesCollection                                         // collection
            .document(uid)                                              // id user
            .collection("recent-messages")                              // ollection recent messages
            .order(by: "timestamp", descending: true)                   // sort by time
        
        //Listener
        query.addSnapshotListener { snapshot, _ in
            // changes is doc -> filter -> and add added or moded message
            guard let changes = snapshot?.documentChanges.filter( { $0.type == .added || $0.type == .modified} ) else { return }
            //teper vse poluchanie danie kotorie add i mod budut dobavleni
            self.docChanges = changes
        }
    }
}

