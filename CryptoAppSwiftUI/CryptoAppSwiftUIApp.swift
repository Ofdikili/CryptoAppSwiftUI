//
//  CryptoAppSwiftUIApp.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 7.02.2025.
//

import SwiftUI

@main
struct CryptoAppSwiftUIApp: App {
    var coins : [CoinModel] = CoinModel.mockCoinData
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
