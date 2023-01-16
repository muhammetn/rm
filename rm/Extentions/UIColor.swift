//
//  UIColor.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

enum Color: String {
    
    case backgroundColor
    case cardColor
    case greenColor
    case mainColor
    case passiveTextColor
    case redColor
    case strokeColor
    case secondaryCardColor
    
}


extension UIColor {
    
    @objc class var backgroundColor: UIColor {
        return UIColor(named: Color.backgroundColor.rawValue) ?? .white
    }
    
    @objc class var cardColor: UIColor {
        return UIColor(named: Color.cardColor.rawValue) ?? .white
    }
    
    @objc class var greenColor: UIColor {
        return UIColor(named: Color.greenColor.rawValue) ?? .white
    }
    
    @objc class var mainColor: UIColor {
        return UIColor(named: Color.mainColor.rawValue) ?? .white
    }
    
    @objc class var passiveTextColor: UIColor {
        return UIColor(named: Color.passiveTextColor.rawValue) ?? .white
    }
    
    @objc class var redColor: UIColor {
        return UIColor(named: Color.redColor.rawValue) ?? .white
    }
    
    @objc class var strokeColor: UIColor {
        return UIColor(named: Color.strokeColor.rawValue) ?? .white
    }
    
    @objc class var secondaryCardColor: UIColor {
        return UIColor(named: Color.secondaryCardColor.rawValue) ?? .white
    }
    
    
    
//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 16) & 0xFF,
//            green: (rgb >> 8) & 0xFF,
//            blue: rgb & 0xFF
//        )
//    }
}
