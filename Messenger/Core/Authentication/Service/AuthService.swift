//
//  AuthService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI
import FirebaseAuth

//MARK: - All func conect and work is async await
class AuthService {
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?
    
    private init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUD: User id for session: \(String(describing: userSession?.uid))")
    }
    
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: - Failed SignIn User, error: \(error.localizedDescription)")
        }
        
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: - Failed Create User, error: \(error.localizedDescription)")
        }
        
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil   
        } catch {
            print("DEBUD: Failure signOut, error: \(error.localizedDescription)")
        }
    }
    
}
