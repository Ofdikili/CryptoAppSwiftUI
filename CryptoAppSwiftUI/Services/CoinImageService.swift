//
//  CoinImageService.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import Foundation
import UIKit
import Combine

class CoinImageService {
    @Published var image :UIImage? = nil
    
    private var imageSubsctiption: AnyCancellable?

    
    init(urlString:String){
        getCoinImage(urlString:urlString)
    }
    
    private func getCoinImage(urlString:String){
        guard let url = URL(string: urlString) else {
            return ;
        }
        
        imageSubsctiption = NetworkingManager.download(url: url)
            .tryMap({
                data->UIImage? in return UIImage(data: data)
            }).sink(receiveCompletion: NetworkingManager.handleCompletion,
            receiveValue:{ [weak self] image in
                self?.image = image
                self?.imageSubsctiption?.cancel()
            })
    }
}
