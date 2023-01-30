//
//  AuthHelper.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation


class AuthHelper {
    
    static let shared = AuthHelper()
    
    init() {}
    
    var auth: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "auth")
        }
        get {
            return UserDefaults.standard.bool(forKey: "auth")
        }
    }
    
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
        get {
            UserDefaults.standard.string(forKey: "token")
        }
    }
    
    var userId: Int? {
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
        get {
            UserDefaults.standard.integer(forKey: "userId")
        }
    }
    
    var username: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "username")
        }
        get {
            UserDefaults.standard.string(forKey: "username")
        }
    }
    
//    MARK: car = carID
    var car: Int? {
        set {
            UserDefaults.standard.set(newValue, forKey: "car")
        }
        get {
            UserDefaults.standard.integer(forKey: "car")
        }
    }
    
    var carNameRu: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "carNameRu")
        }
        get {
            UserDefaults.standard.string(forKey: "carNameRu")
        }
    }
    
    var carNameTm: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "carNameTm")
        }
        get {
            UserDefaults.standard.string(forKey: "carNameTm")
        }
    }
    
    var getCarName: String? {
        let currentLang = AppLanguage.currentAppleLanguage()
        return currentLang == "ru" ? carNameRu : carNameTm
    }
}
