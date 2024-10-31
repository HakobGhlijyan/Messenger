//
//  ChatBubble.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

struct ChatBubble: Shape {
    let isFromeCurrentUser: Bool

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [
                .topLeft,
                .topRight,
                isFromeCurrentUser ? .bottomLeft : .bottomRight
            ],
            cornerRadii: .init(width: 16, height: 16)
        )
        
        return Path(path.cgPath)
    }
}

#Preview {
    VStack {
        ChatBubble(isFromeCurrentUser: true)
            .frame(height: 100)
        ChatBubble(isFromeCurrentUser: false)
            .frame(height: 100)
    }
    .padding()
}
