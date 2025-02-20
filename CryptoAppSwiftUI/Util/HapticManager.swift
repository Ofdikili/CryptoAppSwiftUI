//
//  HapticManager.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 20.02.2025.
//

import Foundation
import SwiftUI
class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type : UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
        print("✅ Haptic feedback triggered!") 
    }
}
