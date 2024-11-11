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
    
    //MARK: - Current User -> on vizivvaetsya asynxronno                //1. async rabotaet tak chto vse stroki budut rabotat posledovatelno
    @MainActor func fetchCurrentUser() async throws {                   // poka odna stroka ne zakonchit vtoraya ne nachnet rabotat
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
    
    //MARK: - ALL user -> asynxronno
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap( { try? $0.data(as: User.self) } )
    }
    
    //MARK: - user -> no eto budet s escaping
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
//        FirestoreConstants.userCollection.document(uid).getDocument(completion: <#T##(DocumentSnapshot?, (any Error)?) -> Void#>)
        FirestoreConstants.userCollection.document(uid).getDocument { snapshot, _ in
            // 2. etonazivaetsya obranmim vizovom
            // a sdes escaping poka budet vizov , on mojet dlitsya 3 - 4 secundi , a drugie stroki prodoljat rabotat , kogda zakonchitsya
            // on vernetsya i poluchanie snapshot -> danie brabotaet
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    //ETO DUDET VIZIVAT SLUCHTEL LISENER - SRAZU POSLE POLUSHENIYA DANIX USER COMPLITION VERNET EGO DLYA SLUCHATELYA
    
}
