//
//  HapticsManager.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 21..
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        feedbackGenerator.notificationOccurred(feedbackType)
    }
}

func haptic(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.isHapticsOn) {
        HapticsManager.shared.trigger(feedbackType)
    }
}
