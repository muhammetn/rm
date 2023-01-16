//
//  UIFonts.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

enum TTCommons: String {
    
    case medium = "TTCommons-Medium"
    case semiBold = "TTCommons-DemiBold"
    case regular = "TTCommons-Regular"
    
}

enum Fonts: String {
    
    case H1
    case H2
    case S1Regular
    case S1Semibold
    case B1Regular
    case B1Medium
    case B1Semibold
    case B2
    case B3
    case B4
    
}

extension UIFont {
    
    convenience init(font: Fonts) {
        switch font {
        case .H1:
            self.init(name: TTCommons.semiBold.rawValue, size: 24 * KeyWords.widthRatio)!
        case .H2:
            self.init(name: TTCommons.semiBold.rawValue, size: 20 * KeyWords.widthRatio)!
        case .S1Regular:
            self.init(name: TTCommons.regular.rawValue, size: 18 * KeyWords.widthRatio)!
        case .S1Semibold:
            self.init(name: TTCommons.semiBold.rawValue, size: 18 * KeyWords.widthRatio)!
        case .B1Regular:
            self.init(name: TTCommons.regular.rawValue, size: 16 * KeyWords.widthRatio)!
        case .B1Medium:
            self.init(name: TTCommons.medium.rawValue, size: 16 * KeyWords.widthRatio)!
        case .B1Semibold:
            self.init(name: TTCommons.semiBold.rawValue, size: 16 * KeyWords.widthRatio)!
        case .B2:
            self.init(name: TTCommons.medium.rawValue, size: 14 * KeyWords.widthRatio)!
        case .B3:
            self.init(name: TTCommons.regular.rawValue, size: 13 * KeyWords.widthRatio)!
        case .B4:
            self.init(name: TTCommons.medium.rawValue, size: 12 * KeyWords.widthRatio)!
        }
    }
    
}
