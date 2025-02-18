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
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.portfolioCoins.append(DeveloperPreviewProvider.instance.coin)
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
            }
    
    
    private func filterCoin(text:String , coins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        var lowercasedText = text.lowercased()
        return coins.filter{ (coin)-> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||                                   coin.symbol.lowercased().contains(lowercasedText)  ||
                   coin.id.lowercased().contains(lowercasedText)
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
    }
   
    }

