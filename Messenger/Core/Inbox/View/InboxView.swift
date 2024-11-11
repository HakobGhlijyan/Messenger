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
            List {
                ActiveNowView()                                                       //7 kak sdes , i nem ego vew est nav link
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                
                ForEach(viewModel.recentMessages) { message in
                    ZStack {
                        NavigationLink(value: message) {
                            EmptyView()
                        }
                        .opacity(0)
                        InboxRowView(message: message)
                    }
                }
            }
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .onChange(of: selectedUser, { oldValue, newValue in
                showChat = newValue != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
//            .navigationDestination(for: User.self, destination: { user in         //1 eto bilo do togo kak dobavil route
//                ProfileView(user: user)
//            })
            .navigationDestination(for: Route.self, destination: { route in           //2 eto teper budet route chtob cherez switch mi ponili k komu oerexodim
                switch route {                                                        //3 pereberaem route , tam 2 varianta ,
                case .profile(let user):                                              //4 1 vrian esli profile path budet kak v toolbat nav link tam
                    ProfileView(user: user)                                           //5 NavigationLink(value: Route.profile(user)) -> pereydet k profilu usera a
                case .chatView(let user):                                             //6 a esli chat to pereydem k chat view
                    ChatView(user: user)                                              //7 v cahte kak v list NavigationLink(value: Route.chatView(user)) {  v active now view
                }                                                                     // TAK MI BUDEM ZNAT KUDA PEREXODIT ISPOLZUYA USER KAK VALUE
            })
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
                        if let user {
                            NavigationLink(value: Route.profile(user)) {
                                CircleProfileImageView(user: user, size: .xSmall)
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
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
