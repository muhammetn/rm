//
//  API.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Alamofire

//if let data = response.data {
//  do {
//      let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//      print(json)
//  } catch {
//      print(error.localizedDescription)
//  }
//}

class APIDataProvider {
    
    static var shared = APIDataProvider()
    
    init() {}
    
    let BASE_URL = "http://95.85.125.228:3540/api"
    
    public func request<Model: Codable>(url: String, method: HTTPMethod = .get, params: [String: Any]? = nil, withAuth: Bool = false, completion: @escaping(Result<Model, NetworkError>)->()) {
        
        if !isConnectedToInternet() {
            completion(.failure(.noInternet))
        }
        
        guard let url = URL(string: "\(BASE_URL)\(url)") else {
            return completion(.failure(.involidUrl))
        }
        var headers: HTTPHeaders = [.init(name: "Content-Type", value: "application/json"), .init(name: "Accept", value: "*/*")]
        
        if withAuth {
            guard let token = AuthHelper.shared.token else {
                return completion(.failure(.unauthorized))
            }
            let tokenTest = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODIwODA3MDcsInJvbGUiOiJ1c2VyIiwidXNlcl9pZCI6IjEifQ.R4TLf4BY5bg4BV1H0oa6ww3Id77EbK29sJLN1IsYDodRBloNo1uQ-70_vWH9gbdHOPiDia8xcVkZFFOOz0X0GA"
            headers.add(.authorization(bearerToken: tokenTest))
            print(tokenTest)
        }
        AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response<Model>.self) { response in
            switch response.result {
            case .success(let data):
                if data.error ?? true {
                    return completion(.failure(.customError(data.message?.getError() ?? "something went wrong!")))
                }
                guard let result = data.body else {
                    return completion(.failure(.nullData))
                }
                completion(.success(result))
            case .failure(_):
                completion(.failure(.incorrectJson))
//                print(error.localizedDescription)
            }
        }
//        AF.request(url,
//                   method: method,
//              parameters: params,
//                encoding: URLEncoding.default,
//                 headers: headers)
////            .validate(contentType: ["application/json"])
//            .response { (response) in
//              if let data = response.data {
//                  do {
//                      let json = JSONDecoder()
//                      let result = try json.decode(Response<Model>.self, from: data)
////                      print(result)
//                      if (result.error ?? true) {
//                          return completion(.failure(.customError(result.message?.getError() ?? "something went wrong!")))
//                      }
//                      completion(.success(result.body))
//                  } catch {
//                      return completion(.failure(.incorrectJson))
//                  }
//              }
//
//        }
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
}
