//
//  Car.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation


struct Car: Codable {
    var model_id: Int?
    var title: String?
    var title_ru: String?
    var primary_price: Double?
    var image: String?
    
    func getTitle() -> String {
        return AppLanguage.currentAppleLanguage() == "ru" ? title_ru ?? "" : title ?? ""
    }
}
