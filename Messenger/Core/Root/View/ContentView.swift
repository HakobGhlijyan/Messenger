//
//  ContentView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 26.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                InboxView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
