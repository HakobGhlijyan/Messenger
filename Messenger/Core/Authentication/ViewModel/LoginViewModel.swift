//
//  LoginViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login() async throws {
        try await AuthService.shared.logIn(withEmail: email, password: password)
    }
}
