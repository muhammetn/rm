//
//  ServicesDataProvider.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Alamofire

protocol ServicesDataProviderType {
    func getCarModels(completion: @escaping (Result<[Car], NetworkError>)->())
    func getWasher(completion: @escaping (Result<[Washer], NetworkError>) -> Void)
    func getService(type: String, completion: @escaping (Result<[Service], NetworkError>) -> Void)
    func getServicePackage(completion: @escaping (Result<[ServicePackage], NetworkError>) -> Void)
}

//class ServicesDataProvider {
//    static var shared = ServicesDataProvider()
//
//    init() { }
//}


extension APIDataProvider: ServicesDataProviderType {
    
    func getCarModels(completion: @escaping (Result<[Car], NetworkError>) -> ()) {
        let url = "/get-car-models"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<[Car], NetworkError>) in
            switch result {
            case .success(let cars):
                completion(.success(cars))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWasher(completion: @escaping (Result<[Washer], NetworkError>) -> Void) {
        let url = "/get-washers"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<[Washer], NetworkError>) in
            switch result {
            case .success(let washers):
                completion(.success(washers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getService(type: String, completion: @escaping (Result<[Service], NetworkError>) -> Void) {
        let url = "/get-services-by-type?type=\(type)"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<[Service], NetworkError>) in
            switch result {
            case .success(let services):
                completion(.success(services))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getServicePackage(completion: @escaping (Result<[ServicePackage], NetworkError>) -> Void) {
        let url = "/get-service-packages"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<[ServicePackage], NetworkError>) in
            switch result {
            case .success(let services):
                completion(.success(services))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func createOrder(params: [String: Any], completion: @escaping (Result<String, NetworkError>) -> Void) {
//        let url = "/create-order-user0"
//        APIDataProvider.shared.request(url: url, method: .put, params: params, withAuth: true) { (result: Result<String, NetworkError>) in
//            switch result {
//            case .success(let success):
//                completion(.success(success))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    
    
}
