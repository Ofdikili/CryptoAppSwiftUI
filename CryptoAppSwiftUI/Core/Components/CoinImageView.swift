//
//  CoinImageView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 9.02.2025.
//

import Foundation
import SwiftUI

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    init() {
        getImage()
    }
    
    private func getImage() {


    }
}

struct CoinImageView: View {
    @StateObject private var viewModel = CoinImageViewModel()
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
