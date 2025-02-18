//
//  PreviewProvider.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import Foundation
import SwiftUI

//extension PreviewProvider{
//    static var dev : DeveloperPreviewProvider{
//        return DeveloperPreviewProvider.instance
//    }
//}

class DeveloperPreviewProvider {
    static let instance = DeveloperPreviewProvider()
    
    private init() {}
    
    let homeVm = HomeViewModel()
    
    let coin : CoinModel = CoinModel.mockCoinData.first!
    
    let stats : StatisticModel = StatisticModel(title: "Market Cap", valeue: "$12.58n", percentageChange: 25.34)
    let stats1 : StatisticModel = StatisticModel(title: "Total Valume", valeue: "1.23Tr")
    let stat2 : StatisticModel = StatisticModel(title: "Market Cap", valeue: "$12.58n")
    
}
