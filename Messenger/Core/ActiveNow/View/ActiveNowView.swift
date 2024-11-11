//
//  ActiveNowView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject private var viewModel: ActiveNowViewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: Route.chatView(user)) {    
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                CircleProfileImageView(user: user, size: .medium)
                                
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                            }
                            Text(user.firstName)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

#Preview {
    ActiveNowView()
}
