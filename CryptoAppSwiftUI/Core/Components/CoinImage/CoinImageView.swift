//
//  CoinImageView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import Foundation
import SwiftUI



struct CoinImageView: View {
    @StateObject private var viewModel : CoinImageViewModel
    
    init(coin:CoinModel){
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        
        ZStack{
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if(viewModel.isLoading){
                ProgressView()
            }else{
                Image(systemName: "questionmark")
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperPreviewProvider.instance.coin)
}
