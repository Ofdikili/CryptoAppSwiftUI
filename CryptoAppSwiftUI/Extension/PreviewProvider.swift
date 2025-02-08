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
    
    let coin : CoinModel = CoinModel.mockCoinData.first!
}
