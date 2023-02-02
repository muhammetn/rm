//
//  OrdersDataProvider.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

protocol OrdersDataProviderType {
    
    func createOrder(services: String, package: Int, car_model: Int, car_no: String, car_type: String, is_booked: Bool, book_time: String, washer_id: Int, washer_count: Int, completion: @escaping(Result<String, NetworkError>) -> ())
    func getOrders(page: Int, completion: @escaping(Result<[Order], NetworkError>) -> ())
    
    func getOrderDetail(order_id: Int, completion: @escaping(Result<Order, NetworkError>) -> ())
    
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
        APIDataProvider.shared.request(url: url, method: .put, params: params, withAuth: true) { (result: Result<String, NetworkError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(page: Int, completion: @escaping (Result<[Order], NetworkError>) -> ()) {
        let url = "/get-user-orders?page=\(page)&per_page=20"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<[Order], NetworkError>) in
            switch result {
            case .success(let orders):
                completion(.success(orders))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getOrderDetail(order_id: Int, completion: @escaping (Result<Order, NetworkError>) -> ()) {
        let url = "/get-user-order?order_id=\(order_id)"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<Order, NetworkError>) in
            switch result {
            case .success(let order):
                completion(.success(order))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
