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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .messagesCollection
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        //Listener
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter( { $0.type == .added || $0.type == .modified} ) else { return }
            self.docChanges = changes
        }
    }
}

//private func fetchUsers() async throws {
//    guard let currentUID = Auth.auth().currentUser?.uid else { return }
//    let users = try await UserService.fetchAllUsers(limit: 6)
//    self.users = users.filter( { $0.id != currentUID })   //sdes mi otsortiruem user ov chtom to kotoriy currrent ne pokazival v verxu
//}

