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

//MARK: Protocol to manage the requests
protocol NetworkManagerProtocol {
    
    associatedtype Provider
    func requestObject<T: Codable>(service: Provider, completionHandler: @escaping(ApiResponse<T>)->())
}

//MARK: NetworkManager to make request to server.
struct NetworkManager<U: ApiTargetType>: NetworkManagerProtocol {
    
    init() {
    }
    
    private let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.maxRequestTime)
        configuration.timeoutIntervalForResource = TimeInterval(AppConstant.maxRequestTime)
        return Session(
            configuration: configuration)
    }()
    
    internal func requestObject<T: Codable>(service:U, completionHandler: @escaping(ApiResponse<T>)->()) {
        if !Reachbility.isConnected{
            GlobalFunction.showEmptyView(.noInternet, nil)
            return
        }
        var parameters = service.defaultParams()
        parameters?.append(anotherDict: service.parameters ?? [String:Any]())
        
        manager.request(service.path,
                        method: service.method,
                        parameters: parameters,
                        encoding: service.encoding,
                        headers: service.headers).responseData { (response) in
            switch response.result {
                
            case .success(let value):
                do {
                    self.evaluateRequestAndErrorResponse(path: service.path, data: value)
                    if let data = String(data: value, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "\\n").data(using: String.Encoding.utf8) {
                        let model: T = try JSONDecoder().decode(T.self, from: data)
                        print("Success 😍: \(model)")
                        completionHandler(.success(value: model))
                    }
                } catch let error {
                    print("JSONDecoder Error 😥: \(error)")
                    let apiError = ApiError(message: error.localizedDescription, code: "")
                    showErrorPopup(.serverError, apiError)
                    completionHandler(.failure(error: apiError))
                }
            case .failure(let error):
                print("Error 😥: \(String(describing: error.responseCode))")
                let apiError = ApiError(message: error.localizedDescription, code: "\(String(describing: error.responseCode))")
                showErrorPopup(.serverError, apiError)
                completionHandler(.failure(error: apiError))
            }
        }
    }
}

//MARK: Evaluate Request & Response
extension NetworkManager{
    
    private func evaluateRequestAndErrorResponse(path:String, data:Data){
        print("request path :\(path)")
        print("success :\(String(describing: String(data: data, encoding: .utf8)))")
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            if let jsondata = json as? [String: Any], let error = jsondata["error"] as? [String: Any], let message = error["message"] as? String, let code = error["code"] as? String {
                let apiError = ApiError(message: message, code: code)
                showErrorPopup(.serverError, apiError)
                return
            }
            
            if let jsondata = json as? [String: Any], let data = jsondata["data"] as? [[String: Any]] {
                if data.count == 0{
                    showErrorPopup(.noData, nil)
                    return
                }
            }
            print(String(decoding: data, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }
    
    private func showErrorPopup(_ emptyType:EmptyViewType? = .serverError, _ error:ApiError? = nil){
        DispatchQueue.main.async {
            GlobalFunction.showEmptyView(emptyType, error)
        }
    }
}
