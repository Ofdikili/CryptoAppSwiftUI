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
    var fileManager = LocalFileManager.instance
    private let coin:CoinModel
    private let folderName:String = "CoinImages"
    private let imageName : String
    
    init(coin:CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        
        if let imageData = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = imageData
            print("retreived from local cache")
        }else{
            print("Starting Downloading Image")

            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
      
        guard let url = URL(string: coin.image) else {
            return ;
        }
        
        imageSubsctiption = NetworkingManager.download(url: url)
            .tryMap({
                data->UIImage? in return UIImage(data: data)
            }).sink(receiveCompletion: NetworkingManager.handleCompletion,
            receiveValue:{ [weak self] image in
                guard let self = self else { return }
                self.image = image
                self.imageSubsctiption?.cancel()
                self.fileManager.saveImage(image: image!, folderName: self.folderName, imageName: self.imageName)
            })
    }
}
