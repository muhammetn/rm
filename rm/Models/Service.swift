//
//  Service.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

struct Service: Codable {
    var service_id: Int?
    var title: String?
    var title_ru: String?
    var price: Double?
    var price_big: Double?
    var description: String?
    var description_ru: String?
    var duration: Int?
    var min_washer: Int?
    
    func getTitle() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (title_ru ?? "") : (title ?? "")
    }
    
    func getDesc() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        return lang == "ru" ? (description_ru ?? "") : (description ?? "")
    }
}

extension Service: Equatable {
    static func == (lhs: Service, rhs: Service) -> Bool {
        return (lhs.service_id ?? 0) == (rhs.service_id ?? -1)
    }
}
