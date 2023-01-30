//
//  ServicePackage.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

struct ServicePackage: Codable {
    var sp_id: Int?
    var title: String?
    var title_ru: String?
    var price: Double?
    var price_big: Double?
    
    func getTitle() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (title_ru ?? "") : (title ?? "")
    }
    
    func getPrice() -> Double {
        let car = AuthHelper.shared.car ?? 1
        return car == 1 ? (price ?? 0) : (price_big ?? 0)
        
    }
}
