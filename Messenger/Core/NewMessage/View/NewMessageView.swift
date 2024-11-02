//
//  NewMessageView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct NewMessageView: View {
    @StateObject private var viewModel: NewMessageViewModel = NewMessageViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .modifier(TextFieldViewModifier())
                
                VStack {
                    Text("Contact")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    if searchText.isEmpty {
                        ForEach(viewModel.users) { user in
                            VStack {
                                HStack {
                                    CircleProfileImageView(user: user, size: .small)
                                    
                                    Text(user.fullName)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                                .padding(.leading)
                                
                                Divider()
                                    .padding(.leading, 55)
                            }
                        }
                    }
                }
                    
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NewMessageView()
}
