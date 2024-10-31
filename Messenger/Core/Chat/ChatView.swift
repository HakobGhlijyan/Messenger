//
//  ChatView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

struct ChatView: View {
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                //Header
                VStack {
                    CircleProfileImageView(user: User.mockUser, size: .xLarge)
                    
                    VStack(spacing: 4.0) {
                        Text(User.mockUser.fullName)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Messenger")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                
                //Messages
                
            }
            
            Spacer()
            
            //Messages input
            ZStack(alignment: .trailing) {
                //                TextField("Message...", text: $message)
                //                    .modifier(TextFieldMessagesViewModifier())
                
                TextField("Message...", text: $message, axis: .vertical)
                    .modifier(TextFieldMessagesViewModifier())
                
                Button {
                    
                } label: {
                    Text("Send").fontWeight(.semibold)
                        .padding(.horizontal)
                }
                
            }
            .padding()
            
        }
    }
}

#Preview {
    ChatView()
}
