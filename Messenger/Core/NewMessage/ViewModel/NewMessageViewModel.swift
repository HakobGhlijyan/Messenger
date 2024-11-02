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
        // TEPER MI VISOVIM ETU FUNC SDES CHTOB POLUCHAT VSEX USER OV V MESSAGE VIEW
//        fetchUsers() //'async' call in a function that does not support concurrency
        Task {
            try await fetchUsers()
        }
    }
    
    func fetchUsers() async throws {
    
        //2
        // vishe mi poluchaem vsex user
        // nujno otfiltrovat chrob current user nebilo v spiske !!!!!!!!!!!
        guard let currentUID = Auth.auth().currentUser?.uid else { return }  // poluchaem current user chtob ego vinut iz spiska
        
        let users = try await UserService.fetchAllUsers()                    // poluchim vsex user
        self.users = users.filter( { $0.id != currentUID })                  // otfiltruem ix , esli id ne raven current user id
        
        
        
        
        //1
//        self.users = try await UserService.shared.fetchAllUsers()
//        sdes mi ne budem obrochatsy k singltonu ...
        
//        self.users = try await UserService.fetchAllUsers()
//         fetch all users budet univerasalnim metodom kotoriy dudet davat vsex userov
    
    }
}


// CHTOB ISZABAITSYA OT FIOLET ERRROR
// MI DOBAVIM S USER SERVISE @MAIN ACTOR  I  K VIEW MODEL CHROB UI OBNOVLYALSYA V MAIN
