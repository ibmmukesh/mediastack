//
//  ApiTargetType+Configuration.swift
//  mediastack
//
//  Created by Mukesh Lokare on 05/03/22.
//

import Foundation


extension ApiTargetType {
  
//  var baseURL: URL {
//    print("\(AppConstant.API.baseURL)")
//    return URL(string: AppConstant.API.baseURL)!
//  }
  
    func defaultParams() -> [String: Any]? {
        if let token = KeychainHelper.standard.read(service: "token",
                                                  account: "mediastack.com",
                                                    type: String.self){
            return ["access_key":token]
        }
        return ["":""]
    }
  
}
