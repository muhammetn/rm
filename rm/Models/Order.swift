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
    var total: Double?
    var car_model: Int?
    var car_model_title: String?
    var car_model_title_ru: String?
    var is_booked: Bool?
    var washer_count: Int?
    var services: [Service]?
    
    func getTitle() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (service_title_ru ?? "") : (service_title ?? "")
    }
    
    func getCarModel() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (car_model_title_ru ?? "") : (car_model_title ?? "")
    }
    
}
