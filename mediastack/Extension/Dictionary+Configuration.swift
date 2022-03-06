//
//  Dictionary+Configuration.swift
//  mediastack
//
//  Created by Mukesh Lokare on 05/03/22.
//

import Foundation

extension Dictionary where Key == String, Value == Any {

    mutating func append(anotherDict:[String:Any]) {
        for (key, value) in anotherDict {
            self.updateValue(value, forKey: key)
        }
    }
}
