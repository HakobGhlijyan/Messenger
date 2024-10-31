//
//  ChatMessageCell.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

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
                //1
//                    .clipShape(
//                        .rect(
//                            topLeadingRadius: 12,
//                            bottomLeadingRadius: 12,
//                            bottomTrailingRadius: 0,
//                            topTrailingRadius: 12,
//                            style: .continuous
//                        )
//                    )
                //2
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
                    //1
//                        .clipShape(
//                            .rect(
//                                topLeadingRadius: 12,
//                                bottomLeadingRadius: 0,
//                                bottomTrailingRadius: 12,
//                                topTrailingRadius: 12,
//                                style: .continuous
//                            )
//                        )
                    //2
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
