//
//  HomeView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 8.02.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.theme.backgroundColor
                .ignoresSafeArea()
            VStack{
                HStack{
                    CircleButtonView(imageName: "heart.fill")
                    Spacer()
                    Text("Hello, World!")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.accent)
                    Spacer()
                    CircleButtonView(imageName: "chevron.right")

                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
    }
}
