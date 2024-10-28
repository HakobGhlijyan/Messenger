//
//  InboxView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView: Bool = false
    
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
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                        
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
