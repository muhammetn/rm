//
//  Response.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

struct Response<T: Codable>: Codable {
    var body: T?
    var error: Bool?
    var message: ErrorMessage?
}

