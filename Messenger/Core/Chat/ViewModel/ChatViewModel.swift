//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 05.11.2024.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var messages: [Message] = []
    let user: User
    
    init(user: User) {
        self.user = user
        observeMessages()
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
    
    func observeMessages() {
        MessageService.observeMessages(chatPartner: user) { [weak self] messages in
            self?.messages.append(contentsOf: messages)
        }
    }
}
