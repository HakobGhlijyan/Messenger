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
    
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
    
    func observeMessages() {
        service.observeMessages() { [weak self] messages in
            self?.messages.append(contentsOf: messages)
        }
    }
}
