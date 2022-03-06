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
         
    //App level constants
    static let baseURL = "http://api.mediastack.com" //"9d5171251053b627b16a550d5a57aaa3"
    static let apiAccessKey = "ceea5b1ba7cc3dea6fb496173de66bb4"//TODO: API Key from https://mediastack.com/quickstart with limited api request, update later as per plan.
    static let maxRequestTime = 12
    static let mainStorboard = "Main"
    static let imagePlaceholder = "ImagePlaceholder"
    static let noInternetIcon = "NoInternetIcon"
    static let noInternet = "No Internet Connection."
    static let noData = "No any data found."
}
