//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 05.11.2024.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func sendMessage() {
        MessageService.sendMessage(messageText, toUser: user)
    }
}

