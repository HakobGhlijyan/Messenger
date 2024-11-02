//
//  NewMessageViewMOdel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 02.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
final class NewMessageViewModel: ObservableObject {
    @Published var users: [User] = []

    init() {
        Task { try await fetchUsers() }
    }
    
    func fetchUsers() async throws {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter( { $0.id != currentUID })
    }
}
