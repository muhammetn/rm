//
//  KeyWords.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

struct KeyWords {
    
    static let scWidth = UIScreen.main.bounds.width
    static let scHeight = UIScreen.main.bounds.height
    static var widthRatio: CGFloat {
        // For iPhone 5S
        if UIScreen.main.bounds.width <= 320 {
            let size = UIScreen.main.bounds.width / 375
            return size * 0.95
        } else {
            // For other iPhones
            return UIScreen.main.bounds.width / 375
        }
    }
    static let statuBarHeigth = UIApplication.shared.statusBarFrame.height
    static let spacing: CGFloat = 16
    static let borderRadius: CGFloat = 5
    
}
