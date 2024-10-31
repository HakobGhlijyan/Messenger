//
//  InboxRowView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct InboxRowView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
//            Image(systemName: "person.circle.fill")
//                .resizable()
//                .frame(width: 64, height: 64)
//                .foregroundStyle(Color(.systemGray4))
            CircleProfileImageView(user: User.mockUser, size: .medium)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Hakob Ghlijyan")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("Some test message for preview, flabbergasted by the simplicity of SwiftUI")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading) // for first line is not in time section
            }
            
            HStack {
                Text("12:00 PM")
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
        }
        .frame(height: 72)
    }
}

#Preview {
    InboxRowView()
}
