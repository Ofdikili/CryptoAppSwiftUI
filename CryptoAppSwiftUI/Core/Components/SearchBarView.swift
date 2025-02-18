//
//  SearchBarView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ?
                                 Color.theme.secondaryTextColor:
                    Color.theme.accent)
            
            TextField("Search beyy name or symbol",text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName:"xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                    .foregroundStyle(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                    
                    ,
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(color:Color.theme.accent.opacity(0.2),radius:3,x:0,y:0)
        )
        .padding()
    }
}

#Preview("Search Bar Light Mode",traits: .sizeThatFitsLayout){
    SearchBarView(searchText: .constant(""))
}

#Preview("Search Bar Dark Mode",traits: .sizeThatFitsLayout){
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}
