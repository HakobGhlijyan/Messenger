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

/// Tak mi sozdali class kotoriy budet poluchat current user i ego vse data ,
/// v nem mi proveryaem est li user ,
/// potom naxodim ego
/// poluchenogo user decodiruem
/// i naznachem k nachennu current user , i budem ispolzovat uje etio data
