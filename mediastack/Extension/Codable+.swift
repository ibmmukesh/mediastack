//
//  Codable+.swift
//  mediastack
//
//  Created by Mukesh Lokare on 02/03/22.
//

import Foundation

extension NewsParameter {
    
    func toJSON(param:NewsParameter) -> [String:Any] {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(param)
        let json = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
        guard let toJSON =  json as? [String: Any] else{
            return [String: Any]()
        }
        return toJSON
    }
}
