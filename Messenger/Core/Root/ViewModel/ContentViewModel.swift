//
//  ContentViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 01.11.2024.
//

import SwiftUI
import FirebaseAuth
import Combine

final class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared
            .$userSession
            .sink { [weak self] userSessionFromAuthService in
                self?.userSession = userSessionFromAuthService
            }
            .store(in: &cancellables)
    }
    
}
