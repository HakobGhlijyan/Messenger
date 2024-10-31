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
    
    //Vizivaem func iz service v async rejime
    func login() async throws {
        try await AuthService().logIn(withEmail: email, password: password)
    }
}
