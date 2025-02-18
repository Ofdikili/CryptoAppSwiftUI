//
//  UIAplication.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import Foundation
import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
