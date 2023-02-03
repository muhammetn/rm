//
//  String.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import UIKit

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: self)!
        return date
    }
    
    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)!
        return date
    }
//    func localized(bundle: Bundle = .main, tableName: String = "ru") -> String {
//        if let path = bundle.path(forResource: AppLanguage.currentAppleLanguage(), ofType: "lproj"),
//            let bundle = Bundle(path: path) {
//            return bundle.localizedString(forKey: self, value: "**\(self)**", table: tableName)
//        }
//        else if let path = bundle.path(forResource: "Base", ofType: "lproj"),
//            let bundle = Bundle(path: path) {
//            return bundle.localizedString(forKey: self, value: nil, table: tableName)
//        }
//        return self
////        let lang = UserDefaults.standard.string(forKey: "lang") ?? "ru"
////        return NSLocalizedString(self, value: "***\(self)***", comment: "")
//    }
    
    func localized() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "**\(self)**", comment: "")
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
    
}
