//
//  NewMessageView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct NewMessageView: View {
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
                        ForEach(0...10, id: \.self) { user in
                            VStack {
                                HStack {
                                    CircleProfileImageView(user: User.mockUser, size: .small)
                                    
                                    Text("Hakob Ghlijyan")
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
