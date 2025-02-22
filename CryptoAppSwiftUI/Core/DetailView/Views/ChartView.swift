//
//  ChartView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 21.02.2025.
//

import SwiftUI

struct ChartView: View {
    let data : [Double]
    let maxY : Double
    let minY : Double
    let lineColor : Color
    let startingDate : Date
    let endingDate : Date
    @State var percantage : CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0)-(data.first ?? 0)
       lineColor = priceChange > 0 ? Color.theme.greenColor : Color.theme.redColor
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(
                    chartBackground
                )
                
                .overlay(
                    chartOverlay,
                    alignment:.leading
                )
            chartDateLabels
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.linear(duration: 2)){
                    self.percantage = 1
                }
            }
        }
        }
        
        
     
}

extension ChartView {
    private var chartView : some View {
        GeometryReader { geometry in
            Path{
                path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index+1)
                    let yAxis = maxY - minY
                    let yPosition = (1-CGFloat((data[index]-minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: 0, y: 0))
                    }
                    path.addLine(to: CGPoint(x:xPosition,y:yPosition))
                    
                }
            }
            .trim(from:0.0,to: percantage)
            .stroke(
             lineColor,
             style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .shadow(color: lineColor,radius: 10, x: 5,y:0)
            .shadow(color: lineColor.opacity(0.5),radius: 10, x: 5,y:10)
            .shadow(color: lineColor.opacity(0.2),radius: 10, x: 5,y:20)
            .shadow(color: lineColor.opacity(0.1),radius: 10, x: 5,y:30)
         }
    }
    
    private var chartDateLabels : some View {
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
    
    private var chartBackground : some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()

        }
    }
    
    private var chartOverlay : some View {
        VStack(){
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY+minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())

        }
      
    }
}

#Preview {
    ChartView(coin: DeveloperPreviewProvider.instance.coin)
    
}
