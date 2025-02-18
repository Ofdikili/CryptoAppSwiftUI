//
//  MarketingsScatisticsView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import SwiftUI

struct MarketingsScatisticsView: View {
    
    @EnvironmentObject private var homeViewModel : HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack(alignment:.firstTextBaseline){
            ForEach(homeViewModel.statistics){
                statistic in
                StatsColumnView(stats: statistic)
                    .frame(width:UIScreen.main.bounds.width/3)
            }
        }
        .frame(width:UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading
        )
    }
}

#Preview {
    MarketingsScatisticsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreviewProvider.instance.homeVm)
}

#Preview("Dark View"){
    MarketingsScatisticsView(showPortfolio: .constant(true))
        .environmentObject(DeveloperPreviewProvider.instance.homeVm)
        .preferredColorScheme(.dark)
}
