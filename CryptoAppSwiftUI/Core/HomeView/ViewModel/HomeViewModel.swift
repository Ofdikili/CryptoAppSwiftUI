//
//  HomeViewModel.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var showPortfolio: Bool = false
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published  var statistics : [StatisticModel] = []
    @Published var savedEnities: [PortfolioEntity] = []
    
    private let coinDataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
        }
    }
    
    private func addSubscribers() {
        //        coinDataService.$allCoins
        //            .sink { [weak self] (coins) in
        //                self?.allCoins = coins
        //                }
        //                .store(in: &cancellables)
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoin)
            .sink { [weak self] (coins) in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData).sink {
                [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        
        $allCoins.combineLatest(portfolioDataService.$savedEnities)
            .map { (coins, portfolioEntities) -> [CoinModel] in
                coins.compactMap { (coin) -> CoinModel? in
                    guard let entity = portfolioEntities.first(
                        where : {$0.coinID == coin.id}) else{
                        return nil
                    }
                    return coin.updateHoldings(amount:entity.amount)
                    
                }
            }.sink { [weak self] (returnedCoin) in
                self?.portfolioCoins = returnedCoin
            }.store(in: &cancellables)
        
        //    portfolioDataService.$savedEnities.sink { [weak self] (entities) in
        //        self?.savedEnities = entities
        //    }.store(in: &cancellables)
    }
    
    
    private func filterCoin(text:String , coins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter{ (coin)-> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||                                   coin.symbol.lowercased().contains(lowercasedText)  ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    public func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func mapGlobalMarketData(marketData : MarketDataModel?) -> [StatisticModel]{
        var stats : [StatisticModel] = []
        guard let data = marketData else{
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", valeue: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", valeue: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", valeue: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", valeue: "$0.00", percentageChange: 0)
        stats.append(
            contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
        return stats
    }
}
        
//        .map { (text, startingCoins) -> [CoinModel] in
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//                let lowercasedText = text.lowercased()
//                return startingCoins.filter { coin in
//                    coin.name.lowercased().contains(lowercasedText) ||
//                    coin.symbol.lowercased().contains(lowercasedText) ||
//                    coin.id.lowercased().contains(lowercasedText)
//                }
//            }
  
   
    

