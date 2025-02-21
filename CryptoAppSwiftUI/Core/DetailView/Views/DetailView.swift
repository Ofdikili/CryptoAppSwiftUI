//
//  DetailView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 20.02.2025.
//

import SwiftUI

struct DetailViewLoadingView: View {
    @Binding var coin : CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    let  coin : CoinModel
    @StateObject var detailViewModel : DetailViewModel
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing : CGFloat = 30
    init(coin: CoinModel) {
        self.coin = coin
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initilazing DEtailView FOR \(coin.name)")
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                Text("")
                    .frame(height: 150)
                sectionTitle(title: "Overview")
                Divider()
                buildStatsGridView(list: detailViewModel.overviewStatistics)
                sectionTitle(title: "Additional Details")
                Divider()
                buildStatsGridView(list: detailViewModel.additionalStatistics)
                
                

            }
            .padding()
        }.navigationTitle(detailViewModel.coin.name)

    }
}

extension DetailView{
    public func sectionTitle(title: String)->some View{
        return Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth:.infinity, alignment: .leading)
    }
    
    public func buildStatsGridView(list :  [StatisticModel]) -> some View {
       return  LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content:{
            ForEach(list){
                stats in
                StatsColumnView(
                    stats:
                    stats
                )
            }
        })
    }
}

#Preview {
    DetailView(coin: DeveloperPreviewProvider.instance.coin)
}
