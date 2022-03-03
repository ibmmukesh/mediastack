//
//  NetworkReachabilityManager.swift
//  mediastack
//
//  Created by Mukesh Lokare on 03/03/22.
//

import Foundation
import Alamofire

class Reachbility{
    class var isConnected:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
