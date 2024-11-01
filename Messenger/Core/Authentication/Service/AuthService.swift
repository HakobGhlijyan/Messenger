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
    // CRUD (Create, Read, Update, Delete)
    
    // Tak U nas class AuthService -> userSession parametr sozdayotsya v raznix mestax i oni ne odinakovi
    // chtob rechit eto sozdayom singlton etogo class
    static let shared = AuthService()
    // teper on budet tolko obrochatsya k class u
    
    // Teper Mi v Profile View , loginviewmodel , registrationview model . vezde obrochaemsya v singltonu, kotoriy odin i ne 
    
    // Nasha peremennayan dlya otslejivaniya vochol li user ili net
    // eto budet nash Publisher...
    @Published var userSession: FirebaseAuth.User?
    
    private init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUD: User id for session: \(String(describing: userSession?.uid))")
    }
    
    //Log in - Read
    func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: - Failed SignIn User, error: \(error.localizedDescription)")
        }
        
    }
    //Creating - Create
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        //sozdanie user delaetsya v do catch bloke, izza throws
        
        do {
            //asinxronniy setevoy vizov sozronit rezultat
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: - Failed Create User, error: \(error.localizedDescription)")
        }
        
    }
    //Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()       // Sing OUT User
            self.userSession = nil          // update parametr for enable is user log in or no
        } catch {
            print("DEBUD: Failure signOut, error: \(error.localizedDescription)")
        }
    }
    
}
