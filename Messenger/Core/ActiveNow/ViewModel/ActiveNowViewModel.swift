//
//  ActiveNowViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 11.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
final class ActiveNowViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        Task { try await fetchUsers() }
    }
    
    private func fetchUsers() async throws {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers(limit: 6)
        self.users = users.filter( { $0.id != currentUID })  
    }
}
