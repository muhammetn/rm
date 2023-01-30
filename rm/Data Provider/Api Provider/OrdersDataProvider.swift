//
//  OrdersDataProvider.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

protocol OrdersDataProviderType {
    func createOrder(services: String, package: Int, car_model: Int, car_no: String, car_type: String, is_booked: Bool, book_time: String, washer_id: Int, washer_count: Int, completion: @escaping(Result<String, NetworkError>) -> ())
}


extension APIDataProvider: OrdersDataProviderType {
    
    func createOrder(services: String = "", package: Int = 0, car_model: Int, car_no: String, car_type: String, is_booked: Bool = false, book_time: String, washer_id: Int, washer_count: Int, completion: @escaping(Result<String, NetworkError>) -> ()) {
        let url = "/create-order-user0"
        let params: [String: Any] = [
            "services": services,
            "package": package,
            "car_model": car_model,
            "car_no": car_no,
            "car_type": car_type,
            "is_booked": is_booked,
            "book_time": book_time,
            "washer_id": washer_id,
            "washer_count": washer_count
        ]
        APIDataProvider.shared.request(url: url, method: .put, params: params, withAuth: true) { (resukt: Result<String, NetworkError>) in
            switch resukt {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
