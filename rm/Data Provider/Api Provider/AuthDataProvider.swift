//
//  AuthProvider.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Alamofire

protocol AuthDataProviderType {
    
    func startVerification(phone: String, withAuth: Bool, completion: @escaping(Result<String, NetworkError>) -> Void)
    func signUser(phone: String, code: String, completion: @escaping(Result<User, NetworkError>) -> Void)
    func setUserame(username: String, completion: @escaping(Result<String, NetworkError>) -> Void)
    func getUser(completion: @escaping(Result<User, NetworkError>) -> ())
    func modifyPhone(phone: String, code: String, completion: @escaping(Result<String, NetworkError>) -> ())
    
}

extension APIDataProvider: AuthDataProviderType {
    
    func startVerification(phone: String, withAuth: Bool = false, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let url = "/start-verification"
        let params: [String: Any] = [
            "phone": phone
        ]
        
        APIDataProvider.shared.request(url: url, method: .put, params: params, withAuth: withAuth) { (result: Result<String, NetworkError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signUser(phone: String, code: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let url = "/sign-user"
        let params: [String: Any] = [
            "phone": phone,
            "code": code
        ]
        APIDataProvider.shared.request(url: url, method: .post, params: params) { (result: Result<User, NetworkError>) in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setUserame(username: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let url = "/user-modify-name"
        let params: [String: Any] = [
            "username": username
        ]
        APIDataProvider.shared.request(url: url, method: .post, params: params, withAuth: true) { (result: Result<String, NetworkError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUser(completion: @escaping (Result<User, NetworkError>) -> ()) {
        let url = "/get-profile"
        APIDataProvider.shared.request(url: url, withAuth: true) { (result: Result<User, NetworkError>) in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func modifyPhone(phone: String, code: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        let url = "/user-modify-phone-1"
        let params: [String: Any] = [
            "phone": phone,
            "code": code
        ]
        APIDataProvider.shared.request(url: url, method: .post, params: params, withAuth: true) { (result: Result<String, NetworkError>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
