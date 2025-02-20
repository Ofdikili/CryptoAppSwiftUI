//
//  CoinDataService.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubsctiption: AnyCancellable?
    //private var cancellables = Set<AnyCancellable>()

    init() {
        getCoinData()
    }
    
    public func getCoinData(){
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: urlString) else {
            return ;
        }
        
        coinSubsctiption = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
            receiveValue:{ [weak self] coins in
                self?.allCoins = coins
                self?.coinSubsctiption?.cancel()
            })
      }
    }



//private func getCoinData(){
//    let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin%2Cethereum%2Cbinance-usd%2Ccardano%2Cpolkadot%2Csolana%2Cbitcoin-cash%2Cpolkadot-dot"
//    guard let url = URL(string: urlString) else {
//        return ;
//    }
//    
//    URLSession.shared.dataTaskPublisher(for: url)
//        .map { $0.data }
//        .decode(type: [CoinModel].self, decoder: JSONDecoder())
//        .receive(on: DispatchQueue.main)
//        .sink(receiveCompletion: { completion in
//            switch completion {
//            case .failure(let error):
//                print("Error: \(error)")
//            case .finished:
//                break
//            }
//            
//        },
//              receiveValue:{ [weak self] coins in
//            self?.allCoins = coins
//            
//        }).store(in: &cancellables)
//  }
