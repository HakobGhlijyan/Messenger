//
//  ChatView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

//example for use
/*
 struct ChatView: View {
     @State private var message: String = ""
     
     var body: some View {
         VStack {
             ScrollView {
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
                 
                 ForEach(0 ..< 15, id: \.self) { message in
                     ChatMessageCell(isFromeCurrentUser: Bool.random())
                 }
             }
             
             Spacer()
             
             ZStack(alignment: .trailing) {
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
 */
struct ChatView: View {
    @State private var message: String = ""
    let user: User
    
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
                
                ForEach(0 ..< 15, id: \.self) { message in
                    ChatMessageCell(isFromeCurrentUser: Bool.random())
                }
            }
            
            Spacer()
            
            ZStack(alignment: .trailing) {
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
    ChatView(user: User.mockUser)
}
