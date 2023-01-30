//
//  Date.swift
//  rm
//
//  Created by Muhammet Nurchayev on 28.01.2023.
//

import Foundation

extension Date {
//    2023-01-21 16:17
    func toString(dateFormat format : String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
