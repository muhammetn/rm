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
    
//    func dateToString(date: Date = Date()) -> String {
//        let formatter = DateFormatter()
////        2023-01-21 16:17
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let myString = formatter.string(from: date)
//        // convert your string to date
//        let yourDate = formatter.date(from: myString)
//        //then again set the date format which type of output you need
//        formatter.dateFormat = "dd-MMM-yyyy"
//        // again convert your date to string
//        let myStringDate = formatter.string(from: yourDate!)
//        print(myStringDate)
//        return myStringDate
//    }
}
