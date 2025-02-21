//
//  CoinDetailDataService.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 21.02.2025.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubsctiption: AnyCancellable?
    var coin :CoinModel
    //private var cancellables = Set<AnyCancellable>()

    init(coin:CoinModel) {
        self.coin = coin
        getCoinDetail()
    }
    
    public func getCoinDetail(){
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        guard let url = URL(string: urlString) else {
            return ;
        }
        
        coinDetailSubsctiption = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
            receiveValue:{ [weak self] coinDetails in
                self?.coinDetails = coinDetails
                self?.coinDetailSubsctiption?.cancel()
            })
      }
    }
