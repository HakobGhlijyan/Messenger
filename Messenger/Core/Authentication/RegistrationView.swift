//
//  RegistrationView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            // Logo Image
            Image("Facebook-Messenger-logo-clean")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            //TextField
            VStack(spacing: 16.0) {
                TextField("Full Name", text: $fullName)
                    .modifier(TextFieldViewModifier())
                
                TextField("Email", text: $email)
                    .modifier(TextFieldViewModifier())
                
                SecureField("Password", text: $password)
                    .modifier(TextFieldViewModifier())
            }
            
            //Sign Up Button
            Button {
                //action
            } label: {
                Text("Sign Up")
                    .modifier(ButtonViewModifier())
            }
            .padding(.vertical)
            
            Spacer()
            
            //SignIn link
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