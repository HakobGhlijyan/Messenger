//
//  ButtonViewModifier.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 360, height: 44)
            .background(Color(.systemBlue))
            .cornerRadius(10)
    }
}
