//
//  ProfileView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()
    let user: User //user dlya navdestionation
    
    var body: some View {
        VStack {
            //Header
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        //a zdes uje budet nash photo user
//                        Image(user.profileImageUrl ?? "")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 80, height: 80)
//                            .clipShape(Circle())
                        
                        CircleProfileImageView(user: user, size: .xLarge)
                    }
                }
                
                Text(user.fullName)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(user.email)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }
            //List
            List {
                Section {
                    ForEach(SettingsOptionsViewModel.allCases) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(option.imageBackgroundColor)
                            
                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                    }
                    Button("Delete Account") {
                        
                    }
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ProfileView(user: User.mockUser)
}
