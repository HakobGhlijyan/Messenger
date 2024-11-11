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

final class UserService: ObservableObject {
    static let shared = UserService()
    @Published var currentUser: User?
    
    //MARK: - Current User
    @MainActor func fetchCurrentUser() async throws {
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
    
    //MARK: - ALL user
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.userCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) } )
    }
    
    //MARK: - user
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        FirestoreConstants.userCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
