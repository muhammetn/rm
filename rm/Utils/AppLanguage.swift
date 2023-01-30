//
//  AppLanguage.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import UIKit

class AppLanguage {
    // get current Apple language
    class func currentAppleLanguage() -> String {
        _ = Locale.preferredLanguages[0]
        var defLang = "ru"
        return UserDefaults.standard.string(forKey: "lang") ?? defLang
    }
    
    class func setAppleLanguageTo(lang: String) {
        UserDefaults.standard.set(lang, forKey: "lang")
        UserDefaults.standard.synchronize()
    }
}
