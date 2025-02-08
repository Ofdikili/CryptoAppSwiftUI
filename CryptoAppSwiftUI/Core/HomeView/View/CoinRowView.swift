//
//  CoinRowView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import Foundation
import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    let showHoldingColumn : Bool
    var body: some View {
        HStack{
            leftColumn
            Spacer()
            if showHoldingColumn{
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

extension CoinRowView{
    private var leftColumn : some View{
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn : some View{
        VStack(alignment:.trailing){
            Text("\(coin.currentHoldingsValue,specifier: "%.2f")")
                .bold()
            Text("\(coin.currentHoldings ?? 0,specifier: "%.2f")")
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn : some View{
        VStack(alignment:.trailing){
            Text("$\(coin.currentPrice,specifier: "%.2f")")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H ?? 0)")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
        }.frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
    }
}

#Preview("With Show Holding Column",traits: .sizeThatFitsLayout) {
    
    CoinRowView(coin: DeveloperPreviewProvider.instance.coin,showHoldingColumn: true)
}

#Preview("Without Show Holding Column",traits: .sizeThatFitsLayout) {
    
    CoinRowView(coin: DeveloperPreviewProvider.instance.coin,showHoldingColumn: false)
}


