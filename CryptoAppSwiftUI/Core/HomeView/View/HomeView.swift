//
//  HomeView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeViewModel : HomeViewModel
    @State var showPortfolioView: Bool = false
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showCoinDetails: Bool = false
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView().environmentObject(homeViewModel)
                })
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
        }.background(
            NavigationLink(
                destination : DetailViewLoadingView(coin: $selectedCoin),
                isActive:$showCoinDetails,
                label:{
                    EmptyView()
                }
            )
        )

    }
        }



private extension HomeView {
    private var homeHeaderView:some View {
            HStack {
                CircleButtonView(imageName: homeViewModel.showPortfolio ? "plus" : "info")
                    .animation(.none)
                    .onTapGesture {
                        showPortfolioView.toggle()

                    }
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
    
    private func seque(coin : CoinModel){
        selectedCoin = coin
        showCoinDetails.toggle()
    }
    private var allCoinList : some View{
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .onTapGesture {
                        seque(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
        .refreshable(action: {homeViewModel.reloadData()})
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
            HStack{
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(homeViewModel.selectedCoinSortType == .rank || homeViewModel.selectedCoinSortType == .rankReverse ? 1 : 0)
                    .rotationEffect(Angle(degrees: homeViewModel.selectedCoinSortType == .rank ? 0: 180))
                   
            } .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.selectedCoinSortType =  homeViewModel.selectedCoinSortType
                    == .rank ? .rankReverse : .rank
                }
            }
            Spacer()
            if(homeViewModel.showPortfolio){
                HStack{
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(homeViewModel.selectedCoinSortType == .holdings || homeViewModel.selectedCoinSortType == .holdingsReverse ? 1 : 0)
                        .rotationEffect(Angle(degrees: homeViewModel.selectedCoinSortType == .holdings ? 0: 180))
                                        }.onTapGesture {
                                            withAnimation(.default) {
                                                homeViewModel.selectedCoinSortType =  homeViewModel.selectedCoinSortType
                                                == .holdings ? .holdingsReverse : .holdings
                                            }
                                        }

            }
           
            Text("Price") .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                  
                    homeViewModel.reloadData()

                }
            },label: {
                Image(systemName: "goforward")
                   

            })
            .rotationEffect(Angle(degrees: homeViewModel.isLoading  ? 360 : 0))
            
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

