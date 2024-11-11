//
//  InboxViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 02.11.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine

@MainActor
final class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    @Published var recentMessages: [Message] = []
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService
            .shared
            .$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)
        
        service
            .$docChanges
            .sink { [weak self] changes in
                self?.loadInitialMessages(fromeChange: changes)
            }
            .store(in: &cancellables)
    }

    private func loadInitialMessages(fromeChange changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
        for i in 0 ..< messages.count {
            let message = messages[i]
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages.append(messages[i])
            }
        }
    }
}

