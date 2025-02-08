//
//  CircleButtonViews.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct CircleButtonView: View {
    var imageName : String

    var body: some View {
        
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.backgroundColor)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding(10)
            
            
    }
}



#Preview("Circle Light Button", traits: .sizeThatFitsLayout) {
    CircleButtonView(imageName:"heart.fill")
}

#Preview("Circle Dark Button", traits: .sizeThatFitsLayout) {
    CircleButtonView(imageName: "heart.fill")
        .preferredColorScheme(.dark)
}

//struct CircleButtonViews_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            CircleButtonView()
//                .previewLayout(.sizeThatFits)
//                .previewDisplayName("Circle Light Button")
//            CircleButtonView()
//                .previewLayout(.sizeThatFits)
//                .colorScheme(.dark)
//                .previewDisplayName("Circle Dark Button")
//        }
//    }
//}

//ZStack {
//            Circle()
//                .fill(Color.theme.backgroundColor) // Arka plan rengi
//                .frame(width: 50, height: 50)
//                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 2, y: 2) // Gölge efekti
//
//            Image(systemName: "heart.fill")
//                .font(.system(size: 22, weight: .bold))
//                .foregroundStyle(Color.theme.accent) // İkon rengi
//        }
//        .frame(width: 50, height: 50)
