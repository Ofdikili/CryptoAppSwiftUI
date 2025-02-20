//
//  MarketDataService.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketSubsctiption: AnyCancellable?

    init() {
        getMarketData()
    }
    
    func getMarketData(){
        let urlString = "https://api.coingecko.com/api/v3/global"
        guard let url = URL(string: urlString) else {
            return ;
        }
        
        marketSubsctiption = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
            receiveValue:{ [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketSubsctiption?.cancel()
            })
      }
    }
