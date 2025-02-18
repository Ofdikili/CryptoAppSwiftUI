//
//  HomeView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeViewModel : HomeViewModel
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
                MarketingsScatisticsView(showPortfolio: $homeViewModel.showPortfolio)
                SearchBarView(searchText: $homeViewModel.searchText)
                columnTitles
                if !homeViewModel.showPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))

                }
                if homeViewModel.showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))

                }
                Spacer(minLength: 0)

            }.padding()
        }
    }
}



private extension HomeView {
    private var homeHeaderView:some View {
            HStack {
                CircleButtonView(imageName: homeViewModel.showPortfolio ? "plus" : "info")
                    .animation(.none)
                    .background(
                        CircleButtonAnimationView(isAnimating: $homeViewModel.showPortfolio)
                    )
                
                Spacer()
                
                Text(homeViewModel.showPortfolio ? "Portfolio" : "Live Prices")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                CircleButtonView(imageName: "chevron.right")
                    .rotationEffect(Angle(degrees: homeViewModel.showPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            homeViewModel.showPortfolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)
    }
    
    private var allCoinList : some View{
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinList : some View{
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .leading))
    }
    
    private var columnTitles : some View{
        HStack{
            Text("Coin")
            Spacer()
            if(homeViewModel.showPortfolio){
                Text("Holdings")
                   
            }
           
            Text("Price") .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
}

#Preview {
    return HomeView()
        .environmentObject(DeveloperPreviewProvider.instance.homeVm)
}
