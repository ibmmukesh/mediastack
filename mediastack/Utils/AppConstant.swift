//
//  AppConstant.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///AppConstant file to manage application level constants.
///

import Foundation

struct AppConstant {
         
    //MARK: App level constants
    static let maxRequestTime = 12
    static let mainStorboard = "Main"
    static let imagePlaceholder = "ImagePlaceholder"
    static let noInternetIcon = "NoInternetIcon"
    static let noInternet = "No Internet Connection."
    static let noData = "No any data found."
    static let secAttribServiceKey = "secAttribServiceKey"
    static let secAttribAccount = "mediastack.com"

    
    //MARK: Application Environment Setup
    struct API {

        enum Environment {
            case development
            case uat
            case production
            
            var baseURL: String {
                switch self {
                case .development:    return "http://api.mediastack.com"
                case .uat:            return "http://api.mediastack.com"
                case .production:     return "http://api.mediastack.com"
                }
            }
            
            var apiAccessKey: String {
                switch self {
                case .development:    return "ceea5b1ba7cc3dea6fb496173de66bb4"
                case .uat:             return "ceea5b1ba7cc3dea6fb496173de66bb4"
                case .production:     return "ceea5b1ba7cc3dea6fb496173de66bb4"
                }
            }
        }
        
        #if Development
        static let currentEnvironment = Environment.development
        #elseif Uat
        static let currentEnvironment = Environment.uat
        #else
        static let currentEnvironment = Environment.production
        #endif
        
        static let baseURL = currentEnvironment.baseURL
        static let apiAccessKey = currentEnvironment.apiAccessKey
    }
}
