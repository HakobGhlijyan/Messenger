//
//  CircleProfileImageView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 31.10.2024.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var size: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 56
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

struct CircleProfileImageView: View {
    let user: User
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user.profileImageUrl {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: size.size, height: size.size)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.size, height: size.size)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    VStack {
        CircleProfileImageView(user: User.mockUser, size: .xxSmall)
        CircleProfileImageView(user: User.mockUser, size: .xSmall)
        CircleProfileImageView(user: User.mockUser, size: .small)
        CircleProfileImageView(user: User.mockUser, size: .medium)
        CircleProfileImageView(user: User.mockUser, size: .large)
        CircleProfileImageView(user: User.mockUser, size: .xLarge)
    }
}
