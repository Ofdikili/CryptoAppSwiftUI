//
//  CoinImageViewModel.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 17.02.2025.
//

import Foundation
import UIKit
import Combine
class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    private let coin:CoinModel
    private let dataService : CoinImageService
    private var cancellables = Set<AnyCancellable>()
    init(coin:CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(urlString: coin.image)
        self.addSubscribers()
        self.isLoading=true
    }
    
    private func addSubscribers() {
        dataService.$image.sink { [weak self] (_) in
            self?.isLoading = false
        }receiveValue: { [weak self] (returnedImage) in
            self?.image = returnedImage
        }
        .store(in: &cancellables)

    }
}
