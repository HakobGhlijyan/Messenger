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
        // find current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // find user for id
        let shapshot = try await Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .getDocument()
        
        //decode user data is firebase
        let user = try shapshot.data(as: User.self)
        
        // self user = user data
        self.currentUser = user
        
        print("DEBUG: - Current User: \(String(describing: currentUser))")
    }
}
