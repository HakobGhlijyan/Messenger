//
//  ChatView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CircleProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4.0) {
                        Text(user.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
            }
            
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .modifier(TextFieldMessagesViewModifier())
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text("Send").fontWeight(.semibold)
                        .padding(.horizontal)
                }
                
            }
            .padding()
            
        }
        .navigationTitle(user.fullName)
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    ChatView(user: User.mockUser)
}
