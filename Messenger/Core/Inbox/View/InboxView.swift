//
//  InboxView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct InboxView: View {
    @StateObject private var viewModel: InboxViewModel = InboxViewModel()
    @State private var showNewMessageView: Bool = false
    @State private var selectedUser: User?
    @State private var showChat: Bool = false
    
    private var user: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ActiveNowView()
                
                List {
                    ForEach(0...10, id: \.self) { message in
                        InboxRowView()
                    }
                }
                .listStyle(.plain)
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            //Pri vibore stroki s user v onchange , toest ori ismenenii znacheniya selected user , mi otkriem view chat
            .onChange(of: selectedUser, { oldValue, newValue in
                showChat = newValue != nil
                // pri izmenenii selected user showchat stanet true eli on ne nil.
            })
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            //for open user chat view
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        NavigationLink(value: user) {
                            CircleProfileImageView(user: user, size: .xSmall)
                        }
                        Text("Charts")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }

                }
            }
        }
    }
}

#Preview {
    InboxView()
}