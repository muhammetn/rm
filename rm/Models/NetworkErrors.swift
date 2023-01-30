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
            return "networkError"
        case .noInternet:
            return "noInternet"
        case .involidUrl:
            return "involidUrl"
        case .incorrectJson:
            return "incorrectJson"
        case .userExist:
            return "userExist"
        case .unauthorized:
            return "unauthorized"
        case .nullData:
            return "nullData"
        case .customError(let error):
            return error
        }
    }
}
