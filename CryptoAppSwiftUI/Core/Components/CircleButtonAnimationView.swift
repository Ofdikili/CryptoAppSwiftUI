//
//  CircleButtonAnimationView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var isAnimating : Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(isAnimating ? 1.0: 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(isAnimating ? Animation.easeOut(duration: 1.0) : .none)
            
    }
}

#Preview {
    CircleButtonAnimationView(isAnimating: .constant(true))
}
