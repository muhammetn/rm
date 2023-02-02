//
//  Errors.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation


enum NetworkError: Error {
    case networkError
    case noInternet
    case involidUrl
    case incorrectJson
    case userExist
    case unauthorized
    case nullData
    case customError (String)
    
    var customDescription: String {
        switch self {
        case .networkError:
            return "networkError".localized()
        case .noInternet:
            return "noInternet".localized()
        case .involidUrl:
            return "involidUrl".localized()
        case .incorrectJson:
            return "incorrectJson".localized()
        case .userExist:
            return "userExist".localized()
        case .unauthorized:
            return "unauthorized".localized()
        case .nullData:
            return "nullData".localized()
        case .customError(let error):
            return error
        }
    }
}
