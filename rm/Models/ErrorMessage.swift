//
//  ErrorMessage.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

struct ErrorMessage: Codable {
    var text: String?
    var text_ru: String?
    var text_en: String?
    
    func getError() -> String {
        let lang = AppLanguage.currentAppleLanguage()
        switch lang {
        case "ru":
            return text_ru ?? ""
        case "en":
            return text_en ?? ""
        default:
            return text ?? ""
        }
    }
}
