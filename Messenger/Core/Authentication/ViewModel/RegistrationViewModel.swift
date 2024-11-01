//
//  RegistrationViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    
    func createAccount() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullName)
    }
}
