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
    
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.portfolioCoins.append(DeveloperPreviewProvider.instance.coin)
        }
    }
    
    private func addSubscribers() {
        coinDataService.$allCoins
            .sink { [weak self] (coins) in
                self?.allCoins = coins
                }
                .store(in: &cancellables)
            }
    }

