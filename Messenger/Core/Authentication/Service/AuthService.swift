//
//  AuthService.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//MARK: - All func conect and work is async await
 class AuthService {
    static let shared = AuthService()
    @Published var userSession: FirebaseAuth.User?
    
    private init() {
        // userSession ispolzuetsya chtob uznat est li current user ili net . kakoy view otkrit .
        self.userSession = Auth.auth().currentUser
        // kak mi poluchim info . nachnet vipolnaytsya etot task . poluchenie info o user
        // a sdes mi v task vizivaem async func kotoraya v sluchae current user naznachit poluchanuyu data
        Task {
            try await UserService.shared.fetchCurrentUser()
        }
        print("DEBUD: User id for session: \(String(describing: userSession?.uid))")
    }
    
    //MARK: - Section Log In - Sing In - Creating
    
    //MARK: - createUser
     //Chtoob vse rabotalo @MainActor dobavim
     @MainActor func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // make user
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // save user local
            self.userSession = result.user
            //upload user data in firestore
            try await self.uploadUserData(email: email, fullName: fullname, id: result.user.uid)
        } catch {
            print("DEBUG: - Failed Create User, error: \(error.localizedDescription)")
        }
        
    }
    
    //MARK: - Log In
     //Chtoob vse rabotalo @MainActor dobavim
     @MainActor func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: - Failed SignIn User, error: \(error.localizedDescription)")
        }
        
    }
    
    //MARK: - signOut
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil   
        } catch {
            print("DEBUD: Failure signOut, error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Section Data for user
    
    //MARK: - upload
    private func uploadUserData(email: String, fullName: String, id: String) async throws {
        // Make User local
        let user = User(fullName: fullName, email: email, profileImageUrl: nil)
        
        //Encode user data for send in Firestore
        guard let encodeduser = try? Firestore.Encoder().encode(user) else { return }
        
        //upload and save
        try await Firestore
            .firestore()
            .collection("users")
            .document(id)
            .setData(encodeduser)
    }
    
}

// for encode data , but use firestore encoder
extension Encodable {
    func asDictionary() -> [String: Any] {
        // получение данных
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        // JSONSerialization преобразование в json type
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
