//
//  DetailView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 20.02.2025.
//

import SwiftUI

struct DetailViewLoadingView: View {
    @Binding var coin : CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let  coin : CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initilazing DEtailView FOR \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreviewProvider.instance.coin)
}
