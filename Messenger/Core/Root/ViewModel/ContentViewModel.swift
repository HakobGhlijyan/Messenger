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
            .sink { [weak self] userSessionFromAuthService in   //dobavim weak self -> i ?
                self?.userSession = userSessionFromAuthService
                // eto delem v fonovom potoke no ne ukazivaem vernutsya v main dlay ui update
            }
            .store(in: &cancellables)
    }
    
}
