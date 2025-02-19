//
//  CoinVerticalContainer.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 19.02.2025.
//

import SwiftUI

struct CoinLogoView: View {
    var coin : CoinModel
    var body: some View {
        VStack{
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .bold(true)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreviewProvider.instance.coin)
}
