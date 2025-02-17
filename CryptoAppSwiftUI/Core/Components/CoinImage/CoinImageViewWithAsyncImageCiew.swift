//
//  CoinImageView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import SwiftUI

import SwiftUI

struct CoinImageWithAsyncImageView: View {
    let imageUrl: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            case .failure(_):
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.red)

            case .empty:
                ZStack {
                    Color.gray.opacity(0.3)
                    ProgressView()
                }
                .frame(width: 24, height: 24)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    CoinImageWithAsyncImageView(imageUrl: "")
}
