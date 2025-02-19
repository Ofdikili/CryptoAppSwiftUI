//
//  PortfolioView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 19.02.2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack{
                  
                    searchBarView
                    coinLogoList
                    if(selectedCoin != nil){
                        portfolioInputSection
                    }
                }
            }
                .navigationTitle(Text("Edit Portfolio"))
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        XmarkButtonView()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing:4){
                            Button(action:{}, label: {
                                Text("Save")
                                    .font(.headline)
                            })
                        }.opacity(selectedCoin != nil && selectedCoin!.currentHoldings != Double(quantityText) ? 1.0: 0.0)
                    }
                })
        }
    }
}

extension PortfolioView {
    var searchBarView: some View {
        SearchBarView(searchText: $homeViewModel.searchText)
    }
    
    var coinLogoList: some View {
        ScrollView(.horizontal,showsIndicators:false, content:{
            LazyHStack(spacing:10){
                ForEach(homeViewModel.allCoins){coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding(4)
                        .onTapGesture {selectedCoin = coin}
                        .background(content: {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear)
                        })
                }
            }
            .padding(.vertical,4)
            .padding(.leading,8)
        })
    }
    
    var portfolioInputSection : some View {
        VStack{
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount holding:")
                Spacer()
                TextField("Ex:1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value:")
                Spacer()
                Text(getTotalPrice().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private func getTotalPrice()->Double{
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0.0
    }
    
}

#Preview {
    PortfolioView().environmentObject(DeveloperPreviewProvider.instance.homeVm)
}
