//
//  NetworkManager.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///NetworkManager class is the genric class where API call get execute & generic parsing takes place & with the help of escaping closure response sends back.
///Used single responsibility & dependency injection principle.

import Foundation
import Alamofire
import Moya

protocol NetworkManagerProtocol {
    
    associatedtype Provider
    func requestObject<T: Codable>(path: Provider, completionHandler: @escaping(ApiResponse<T>)->())
}
struct NetworkManager<U: TargetType>: NetworkManagerProtocol {
    
    private let provider: MoyaProvider<U>
    
    init(provider: MoyaProvider<U> = MoyaProvider<U>()) {
        self.provider = provider
    }
    
    private let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.maxRequestTime)
        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.maxRequestTime)
        return Session(
            configuration: configuration)
    }()
    
    
    internal func requestObject<T: Codable>(path: U, completionHandler: @escaping(ApiResponse<T>)->()) {
        
        self.provider.request(path) { result in
            switch result {
                
            case .success(let value):
                do {
                    
                    print("request path :\(path)")
                    print("request api:\(String(describing: value.request?.url))")
                    print("success :\(String(describing: String(data: value.data, encoding: .utf8)))")
                    
                    if let json = try? JSONSerialization.jsonObject(with: value.data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        print(String(decoding: jsonData, as: UTF8.self))
                    } else {
                        print("json data malformed")
                    }
                    
                    if let data = String(data: value.data, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "\\n").data(using: String.Encoding.utf8) {
                        let model: T = try JSONDecoder().decode(T.self, from: data)
                        print("Success 😍: \(model)")
                        completionHandler(.success(value: model))
                    }
                } catch let error {
                    print("Error 😥: \(error)")
                    completionHandler(.failure(error: error))
                }
            case .failure(let error):
                print("Error 😥: \(error)")
                completionHandler(.failure(error: error))
            }
        }
    }
}
