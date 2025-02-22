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
    @State private var showFullDescription : Bool = false
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
                ChartView(coin: detailViewModel.coin)
                sectionTitle(title: "Overview")
                Divider()
                descriptionSection
                buildStatsGridView(list: detailViewModel.overviewStatistics)
                sectionTitle(title: "Additional Details")
                Divider()
                buildStatsGridView(list: detailViewModel.additionalStatistics)
                ZStack{
                    if let websiteString = detailViewModel.websiteURL,
                        let url = URL(string: websiteString)
                    {
                        Link(destination: url) {
                            Text("Visit Website")
                                .font(.caption)
                                .foregroundColor(Color.blue)
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
            
            }
            .padding()
        }.navigationTitle(detailViewModel.coin.name)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    toolbarTralingItem
                }
            }

    }
}

extension DetailView{
    public var toolbarTralingItem : some View{
        HStack{
            Text(detailViewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryTextColor)
            CoinImageView(coin: detailViewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
   
    private var descriptionSection : some View{
        ZStack {
            if let coinDescription = detailViewModel.coinDescription{
                VStack(
                    alignment: .leading,
                    spacing:5){
                    Text(coinDescription)
                            .font(.callout)
                        .foregroundColor(.secondary)
                        .lineLimit(showFullDescription ? nil : 3)
                    Button(action:{
                       withAnimation(.easeInOut){
                             showFullDescription.toggle()
                        }
                    },label: {
                        Text(showFullDescription ? "Less.." :"Read More...")
                            .foregroundColor(.blue)
                    })
                        
                    
                }
            }
        }
    }
    
    public func sectionTitle(title: String)->some View{
        return Text(title)
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
