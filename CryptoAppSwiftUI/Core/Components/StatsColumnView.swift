//
//  StatsColumnView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import SwiftUI

struct StatsColumnView: View {
    var stats : StatisticModel
    var body: some View {
        VStack(alignment:.leading,spacing: 4){
            Text(stats.title)
                .font(.caption)
            Text(stats.valeue)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            if(stats.percentageChange != nil){
                HStack{
                    Image(systemName:"triangle.fill")
                        .rotationEffect(Angle(degrees: stats.percentageChange! > 0 ? 0: 180))
                    Text("\(stats.percentageChange ?? 0, specifier: "%.2f%%")")
                }
                .foregroundStyle(stats.percentageChange! > 0 ? Color.theme.greenColor : Color.theme.redColor)
            }
        }
    }
}

#Preview("Without Change Percentage") {
    StatsColumnView(stats: DeveloperPreviewProvider.instance.stats)
}

#Preview ("With Change Percentage"){
    StatsColumnView(stats:DeveloperPreviewProvider.instance.stats1)
        .preferredColorScheme(.dark)
}
