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
        self.userSession = Auth.auth().currentUser
        loadCurrentUserData()
        print("DEBUD: User id for session: \(String(describing: userSession?.uid))")
    }
    
    //MARK: - createUser
    @MainActor func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await self.uploadUserData(email: email, fullName: fullname, id: result.user.uid)
            loadCurrentUserData()
        } catch {
            print("DEBUG: - Failed Create User, error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Log In
    @MainActor func logIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            print("DEBUG: - Failed SignIn User, error: \(error.localizedDescription)")
        }
        
    }
    
    //MARK: - signOut
    @MainActor func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print("DEBUD: Failure signOut, error: \(error.localizedDescription)")
        }
    }
    
    //MARK: - upload
    private func uploadUserData(email: String, fullName: String, id: String) async throws {
        let user = User(fullName: fullName, email: email, profileImageUrl: nil)
        guard let encodeduser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore
            .firestore()
            .collection("users")
            .document(id)
            .setData(encodeduser)
    }
    
    //MARK: - load Current user data
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}

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
