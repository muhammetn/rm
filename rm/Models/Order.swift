//
//  Order.swift
//  rm
//
//  Created by Muhammet Nurchayev on 31.01.2023.
//

import Foundation

struct Order: Codable {
    var order_id: Int?
    var created_at: String?
    var service_title: String?
    var service_title_ru: String?
    var service_type: String?
    var booking_time: String?
    var status: String?
    var order: Int?
    var car_no: String?
    var car_type: String?
    
    func getTitle() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (service_title_ru ?? "") : (service_title ?? "")
    }
    
}
