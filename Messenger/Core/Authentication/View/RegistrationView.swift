//
//  RegistrationView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel: RegistrationViewModel = RegistrationViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            Image("Facebook-Messenger-logo-clean")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack(spacing: 16.0) {
                TextField("Full Name", text: $viewModel.fullName)
                    .modifier(TextFieldViewModifier())
                
                TextField("Email", text: $viewModel.email)
                    .modifier(TextFieldViewModifier())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(TextFieldViewModifier())
            }
            
            Button {
                Task {
                    try await viewModel.createAccount()
                }
            } label: {
                Text("Sign Up")
                    .modifier(ButtonViewModifier())
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Allready have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RegistrationView()
}
