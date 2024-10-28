//
//  TextFieldViewModifier.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .frame(width: 360)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}
