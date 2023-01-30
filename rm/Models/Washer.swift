//
//  Washer.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

struct Washer: Codable {
    var washer_id: Int?
    var name: String?
    var name_ru: String?
    var car_in_process: Int?
    
    func getName() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (name_ru ?? "") : (name ?? "")
    }
}
