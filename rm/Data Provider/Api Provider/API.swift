//
//  API.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

//if let data = response.data {
//  do {
//      let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//      print(json)
//  } catch {
//      print(error.localizedDescription)
//  }
//}
enum Methods: String {
    case POST
    case GET
    case PATCH
    case PUT
    case DELETE
}

class APIDataProvider {
    
    static var shared = APIDataProvider()
    
    init() {}
    
    let BASE_URL = "http://rm-hyzmatlary.com/api"
    
//    public func request<Model: Codable>(url: String, method: HTTPMethod = .get, params: [String: Any]? = nil, withAuth: Bool = false, completion: @escaping(Result<Model, NetworkError>) -> ()) {
//
//        if !isConnectedToInternet() {
//            return completion(.failure(.noInternet))
//        }
//
//        guard let url = URL(string: "\(BASE_URL)\(url)") else {
//            return completion(.failure(.involidUrl))
//        }
//        var headers: HTTPHeaders = [.init(name: "Content-Type", value: "application/json"), .init(name: "Accept", value: "*/*")]
//
//        if withAuth {
//            guard let token = AuthHelper.shared.token else {
//                return completion(.failure(.unauthorized))
//            }
////            let tokenTest = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODIwODA3MDcsInJvbGUiOiJ1c2VyIiwidXNlcl9pZCI6IjEifQ.R4TLf4BY5bg4BV1H0oa6ww3Id77EbK29sJLN1IsYDodRBloNo1uQ-70_vWH9gbdHOPiDia8xcVkZFFOOz0X0GA"
//            headers.add(.authorization(bearerToken: token))
////            print(tokenTest)
//        }
//        AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response<Model>.self) { response in
//            switch response.result {
//            case .success(let data):
//                if data.error ?? true {
//                    return completion(.failure(.customError(data.message?.getError() ?? "something went wrong!".localized())))
//                }
//                guard let result = data.body else {
//                    return completion(.failure(.nullData))
//                }
//                completion(.success(result))
//            case .failure(let error):
//                print(error.localizedDescription)
//                return completion(.failure(.incorrectJson))
//            }
//        }
//    }
    
//    func isConnectedToInternet() -> Bool {
//        return NetworkReachabilityManager()?.isReachable ?? false
//    }
    
    public func request<Model: Codable>(url: String, method: Methods = .GET, params: [String: Any]? = nil, withAuth: Bool = false, completion: @escaping(Result<Model, NetworkError>)->()) {
        
        guard let url = URL(string: "\(BASE_URL)\(url)") else {
            return completion(.failure(.involidUrl))
        }
        
        var urlRequest = URLRequest(url: url)
        
        if withAuth {
            guard let token = AuthHelper.shared.token else {
                return completion(.failure(.unauthorized))
            }
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        let postData = try? JSONSerialization.data(withJSONObject: params ?? [], options: [])
        urlRequest.httpBody = method == .GET ? nil : postData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                if error.localizedDescription == "A data connection is not currently allowed." {
                    return completion(.failure(.noInternet))
                }
                return completion(.failure(.networkError))
            }
            
            guard let data = data else {
                return completion(.failure(.networkError))
            }
            
            do {
                let json = JSONDecoder()
                let result = try json.decode(Response<Model>.self, from: data)
                if !(result.error ?? true) {
                    guard let body = result.body else {
                        return completion(.failure(.nullData))
                    }
                    completion(.success(body))
                } else {
                    guard let errorMsg = result.message else {
                        return completion(.failure(.networkError))
                    }
                    completion(.failure(.customError(errorMsg.getError())))
                }
            } catch {
                completion(.failure(.incorrectJson))
            }
        }
        task.resume()
    }
    
}
