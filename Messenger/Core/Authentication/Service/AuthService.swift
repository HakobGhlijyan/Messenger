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
    
    //Log in - Read
    func logIn(withEmail email: String, password: String) async throws {
        print("DEBUD: Email: \(email), Password: \(password)")
        
    }
    //Creating - Create
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        //sozdanie user delaetsya v do catch bloke, izza throws
        
        do {
            //asinxronniy setevoy vizov sozronit rezultat
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: - Create User: \(result.user.uid)")
        } catch {
            print("DEBUG: - Failed Create User, error: \(error.localizedDescription)")
        }
        
    }
    // 1 - esli budet email ne pravilniy
    // 2 - esli parol menche 6 simvolov
    // 3 - budet sozdan user
    // 4 - ne budet sozdan , budet error chto takoy uke est
    
}
