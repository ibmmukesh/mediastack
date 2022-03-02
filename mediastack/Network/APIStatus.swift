//
//  APIStatus.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

///APIStatus file to manage response status types.
///

import Foundation

struct APIStatusCodes{
    static let success = 0
    static let successWithNoData = 1
    static let AuthFailure = 2
}

struct APIResponseMessage{
    static let success = "SUCCESS"
    static let failure = "FAILURE"
    static let ok = "ok"
    static let error = "error"
}

struct APIContentAndKeys {
    static let contentValue = "application/json"
    static let contentKey = "Content-Type"
 }

