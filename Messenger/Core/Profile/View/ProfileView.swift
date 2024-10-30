//
//  ProfileView.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            //Header
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray4))
                
                Text("Hakob Ghlijyan")
                    .font(.title2)
                    .fontWeight(.semibold)
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
                        
                    }
                    Button("Delete Account") {
                        
                    }
                }
                .foregroundStyle(.red)
                
                
            }
            
            
        }
        
//        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
//            Section(header: Text("foo") ) {
//                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
//                    Section (header: Text("bar") ) {
//                        Text("1")
//                        Text("2")
//                    }
//                    Section (header: Text("baz") ) {
//                        Text("1")
//                        Text("2")
//                    }
//                }
//            }
//        }
        
    }
}

#Preview {
    ProfileView()
}
