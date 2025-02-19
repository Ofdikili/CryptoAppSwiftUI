//
//  XmarkButtonView.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 19.02.2025.
//

import SwiftUI

struct XmarkButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    //@Environment(\.dismiss)  var dismiss
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XmarkButtonView()
}
