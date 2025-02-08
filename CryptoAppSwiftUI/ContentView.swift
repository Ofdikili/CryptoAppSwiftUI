//
//  ContentView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 7.02.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
       NavigationView {
           HomeView()
       }.environmentObject(homeViewModel)
    }
}

#Preview {
    ContentView()
}
