//
//  UserService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 01.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

@MainActor
final class UserService: ObservableObject {
    static let shared = UserService()
    
    @Published var currentUser: User?
    
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let shapshot = try await Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .getDocument()
        let user = try shapshot.data(as: User.self)
        self.currentUser = user
        print("DEBUG: - Current User: \(String(describing: currentUser))")
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) } )
    }
}
