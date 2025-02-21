//
//  StringExtension.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 21.02.2025.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

