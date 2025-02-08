
import Foundation
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    

    static let mockCoinData: [CoinModel] = [
        CoinModel(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png", currentPrice: 58908, marketCap: 1100013258170, marketCapRank: 1, fullyDilutedValuation: 1235028318246, totalVolume: 69075964521, high24H: 59504, low24H: 57672, priceChange24H: 808.94, priceChangePercentage24H: 1.39, marketCapChange24H: 13240944103, marketCapChangePercentage24H: 1.21, circulatingSupply: 18704250, totalSupply: 21000000, maxSupply: 21000000, ath: 64805, athChangePercentage: -9.24, athDate: "2021-04-14T11:54:46.763Z", atl: 67.81, atlChangePercentage: 86630.18, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2021-05-09T04:06:09.766Z", sparklineIn7D: SparklineIn7D(price: [57812.96, 57504.33]), priceChangePercentage24HInCurrency: 1.39, currentHoldings: 1.5),
        
        CoinModel(id: "ethereum", symbol: "eth", name: "Ethereum", image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png", currentPrice: 3908, marketCap: 452001325817, marketCapRank: 2, fullyDilutedValuation: 503502831824, totalVolume: 29075964521, high24H: 3954, low24H: 3767, priceChange24H: 58.94, priceChangePercentage24H: 1.5, marketCapChange24H: 640944103, marketCapChangePercentage24H: 1.23, circulatingSupply: 115000000, totalSupply: nil, maxSupply: nil, ath: 4385, athChangePercentage: -10.2, athDate: "2021-05-12T11:54:46.763Z", atl: 0.43, atlChangePercentage: 908232.34, atlDate: "2015-10-20T00:00:00.000Z", lastUpdated: "2021-05-09T04:06:09.766Z", sparklineIn7D: SparklineIn7D(price: [3800.96, 3850.33]), priceChangePercentage24HInCurrency: 1.5, currentHoldings: 2.3),
        
        CoinModel(id: "cardano", symbol: "ada", name: "Cardano", image: "https://assets.coingecko.com/coins/images/975/large/cardano.png", currentPrice: 1.36, marketCap: 45200132581, marketCapRank: 5, fullyDilutedValuation: 50350283182, totalVolume: 5075964521, high24H: 1.40, low24H: 1.32, priceChange24H: 0.04, priceChangePercentage24H: 3.0, marketCapChange24H: 6409441, marketCapChangePercentage24H: 1.25, circulatingSupply: 32000000000, totalSupply: 45000000000, maxSupply: 45000000000, ath: 2.45, athChangePercentage: -44.3, athDate: "2021-09-02T11:54:46.763Z", atl: 0.017, atlChangePercentage: 8000.12, atlDate: "2017-10-01T00:00:00.000Z", lastUpdated: "2021-05-09T04:06:09.766Z", sparklineIn7D: SparklineIn7D(price: [1.33, 1.35]), priceChangePercentage24HInCurrency: 3.0, currentHoldings: 1000.0),
        
        CoinModel(id: "ripple", symbol: "xrp", name: "XRP", image: "https://assets.coingecko.com/coins/images/44/large/xrp.png", currentPrice: 0.85, marketCap: 39200132581, marketCapRank: 6, fullyDilutedValuation: 45350283182, totalVolume: 5075964521, high24H: 0.87, low24H: 0.81, priceChange24H: 0.02, priceChangePercentage24H: 2.5, marketCapChange24H: 409441, marketCapChangePercentage24H: 1.10, circulatingSupply: 100000000000, totalSupply: nil, maxSupply: nil, ath: 3.84, athChangePercentage: -78.2, athDate: "2018-01-04T11:54:46.763Z", atl: 0.002, atlChangePercentage: 41234.12, atlDate: "2013-08-02T00:00:00.000Z", lastUpdated: "2021-05-09T04:06:09.766Z", sparklineIn7D: SparklineIn7D(price: [0.83, 0.84]), priceChangePercentage24HInCurrency: 2.5, currentHoldings: 5000.0)
    ]

    // Yukarıdaki veri setine 6 coin daha ekleyerek genişletebilirsiniz.
    
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}


/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 58908,
     "market_cap": 1100013258170,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1235028318246,
     "total_volume": 69075964521,
     "high_24h": 59504,
     "low_24h": 57672,
     "price_change_24h": 808.94,
     "price_change_percentage_24h": 1.39234,
     "market_cap_change_24h": 13240944103,
     "market_cap_change_percentage_24h": 1.21837,
     "circulating_supply": 18704250,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 64805,
     "ath_change_percentage": -9.24909,
     "ath_date": "2021-04-14T11:54:46.763Z",
     "atl": 67.81,
     "atl_change_percentage": 86630.1867,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2021-05-09T04:06:09.766Z",
     "sparkline_in_7d": {
       "price": [
         57812.96915967891,
         57504.33531773738,
       ]
     },
     "price_change_percentage_24h_in_currency": 1.3923423473152687
   }
 
 */

