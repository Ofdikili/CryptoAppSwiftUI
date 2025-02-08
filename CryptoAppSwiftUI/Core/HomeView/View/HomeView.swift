//
//  HomeView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                HomeHeaderView(showPortfolio: $homeViewModel.showPortfolio)
                Spacer(minLength: 0)
            }
            
            if homeViewModel.showPortfolio {
                Text("Portfolio")
            }
        }
    }
}



private extension HomeView {
    struct HomeHeaderView: View {
        @Binding var showPortfolio: Bool
        
        var body: some View {
            HStack {
                CircleButtonView(imageName: showPortfolio ? "plus" : "info")
                    .animation(.none)
                    .background(
                        CircleButtonAnimationView(isAnimating: $showPortfolio)
                    )
                
                Spacer()
                
                Text(showPortfolio ? "Portfolio" : "Live Prices")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.theme.accent)
                
                Spacer()
                
                CircleButtonView(imageName: "chevron.right")
                    .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showPortfolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    return HomeView()
}
