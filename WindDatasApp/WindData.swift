//
//  WindData.swift
//  WindDatasApp
//
//  Created by Erencan Evren on 30.04.2018.
//  Copyright © 2018 Cemal Bayrı. All rights reserved.
//

import Foundation
import SwiftyJSON

class WindData {
    var year: String?
    var month: String?
    var day: String?
    var timeUTC: String?
    var windSpeed: Double?
    var direction: String?
    
    var arr: [WindData] = []
    
    func createInstance(_ json: JSON) -> WindData {
        let wind = WindData()
        wind.day = json["day"].stringValue
        wind.month = json["month"].stringValue
        wind.year = json["year"].stringValue
        wind.windSpeed = json["windSpeed"].doubleValue
        wind.direction = json["direction"].stringValue
        
        return wind
    }
    
    func sync(_ json: JSON) {
        arr = []
        for i in 0..<json["array"].count {
            arr.append(createInstance(json["array"][i]))
        }
        
    }
    
    static let shared: WindData = WindData()
}

