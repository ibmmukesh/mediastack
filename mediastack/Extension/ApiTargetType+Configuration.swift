//
//  ApiTargetType+Configuration.swift
//  mediastack
//
//  Created by Mukesh Lokare on 05/03/22.
//

import Foundation


extension ApiTargetType {
    
    //BaseURL based on environment
    var baseURL: String {
        print("\(AppConstant.API.baseURL)")
        return AppConstant.API.baseURL
    }
    
    //Default Parameters
    func defaultParams() -> [String: Any]? {
        if let token = KeychainHelper.standard.read(service: AppConstant.secAttribServiceKey,
                                                    account: AppConstant.secAttribAccount,
                                                    type: String.self){
            return ["access_key":token] //Default Key-Value needs to send with API request.
        }
        return ["":""]
    }
    
}
