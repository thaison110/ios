//
//  HealthModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit
import ObjectMapper


class HealthModel: NSObject, Mappable {
    
    var date : Int64?
    var height : Float?
    var weight : Float?
    
  
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        height <- map["height"]
        date <- map["date"]
        weight <- map["weight"]
        
    }
}
