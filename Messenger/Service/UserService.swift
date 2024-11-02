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
    
    // Fetch all User
    static func fetchAllUsers() async throws -> [User] {
        //1 version
        /*
         let snapshot = try await Firestore          // obrochaemsya k data.. k firestore , k ego users i k vsem ego documentam
             .firestore()                            // tak mi poluchim doumenti , i ostanetsya iz nix vsyat user ov
             .collection("users")
             .getDocuments()
         
         let users = snapshot                        // sdes mi i sozdadim vsex users po ix documentov
             .documents
         //1
             .compactMap { userData in                         // Tak mi proxodim po users i try? probuya sobrat vsex
                 try? userData.data(as: User.self)             // poluchya userData mi data(as: ) decodiruem ix danie
             }                                                 // compact map nam vernet array users i ego vernem
         //2
 //            .compactMap( { try? $0.data(as: User.self) } )
         
         return users
         */
        //2 2 line
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) } )
    }
}
