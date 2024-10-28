//
//  LoginView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 26.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Logo Image
                Image("Facebook-Messenger-logo-clean")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                //TextField
                VStack(spacing: 16.0) {
                    TextField("Email", text: $email)
                        .modifier(TextFieldViewModifier())
                    SecureField("Password", text: $password)
                        .modifier(TextFieldViewModifier())
                }
                
                
                //Forgot Password
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
                
                //Login Button
                Button {
                    //action
                } label: {
                    Text("Login")
                        .modifier(ButtonViewModifier())
                }
                .padding(.vertical)
                
                //Divider "OR"
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                    Text("OR").font(.footnote).fontWeight(.semibold)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 0.5)
                }
                .foregroundStyle(.gray)
                
                //Facebook Login
                
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
                
                //SignIn link
                
                NavigationLink {
                 Text("Sign Up View")
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
