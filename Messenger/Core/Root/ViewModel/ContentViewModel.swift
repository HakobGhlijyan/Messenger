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
    // eto budet nash Subscribers
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
//        AuthService().$userSession.sink { userSession in   //nam nujno sdelat weak self chtob nebilo utechek pamyati.
//            self.userSession = userSession
//        }
        
        AuthService.shared
            .$userSession
            .sink { [weak self] userSessionFromAuthService in   //dobavim weak self -> i ?
                self?.userSession = userSessionFromAuthService
            }
            .store(in: &cancellables)
    }
    
}
