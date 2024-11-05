//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

struct ChatMessageCell: View {
    let message: Message // all messeage for ui view
    private var isFromeCurrentUser: Bool {
        return message.isfromeCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromeCurrentUser {
                Spacer()
                
                Text(message.messageText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromeCurrentUser: isFromeCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5 , alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8.0) {
                    CircleProfileImageView(user: User.mockUser, size: .xxSmall)
                    
                    Text(message.messageText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromeCurrentUser: isFromeCurrentUser))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.75 , alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}


//for feck data
/*
 
 
 struct ChatMessageCell: View {
     let isFromeCurrentUser: Bool
     
     var body: some View {
         HStack {
             if isFromeCurrentUser {
                 Spacer()
                 
                 Text("This is a test message for new is longer message. let's see how it looks!")
                     .font(.subheadline)
                     .padding(12)
                     .background(Color(.systemBlue))
                     .foregroundStyle(.white)
                     .clipShape(ChatBubble(isFromeCurrentUser: isFromeCurrentUser))
                     .frame(maxWidth: UIScreen.main.bounds.width / 1.5 , alignment: .trailing)
             } else {
                 HStack(alignment: .bottom, spacing: 8.0) {
                     CircleProfileImageView(user: User.mockUser, size: .xxSmall)
                     
                     Text("This is a test message for new!")
                         .font(.subheadline)
                         .padding(12)
                         .background(Color(.systemGray5))
                         .foregroundStyle(.black)
                         .clipShape(ChatBubble(isFromeCurrentUser: isFromeCurrentUser))
                         .frame(maxWidth: UIScreen.main.bounds.width / 1.75 , alignment: .leading)
                     
                     Spacer()
                 }
             }
         }
         .padding(.horizontal, 8)
     }
 }

 #Preview {
     VStack {
         ChatMessageCell(isFromeCurrentUser: true)
         ChatMessageCell(isFromeCurrentUser: false)
     }
 }

 
 */
