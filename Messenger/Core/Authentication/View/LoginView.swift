//
//  LoginView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 26.10.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                
                Image("Facebook-Messenger-logo-clean")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack(spacing: 16.0) {
                    TextField("Email", text: $viewModel.email)
                        .modifier(TextFieldViewModifier())
                    SecureField("Password", text: $viewModel.password)
                        .modifier(TextFieldViewModifier())
                }
                
                Button {
                    //action
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task {
                        try await viewModel.login()
                    }
                } label: {
                    Text("Login")
                        .modifier(ButtonViewModifier())
                }
                .padding(.vertical)
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                    Text("OR").font(.footnote).fontWeight(.semibold)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                }
                .foregroundStyle(.gray)
                                
                HStack {
                    Image("Facebook-logo-clean")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("Continue with Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                .padding(.top, 8)
                
                Spacer()
                
                Divider()
                                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Dont have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical)
                
            }
        }
    }
}

#Preview {
    LoginView()
}
