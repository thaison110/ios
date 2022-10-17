//
//  CommonModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit
import ObjectMapper



class MetaResponse : NSObject, Mappable {
    
    var message : String = ""
    var status : Int = 0
    var data : [String:Any]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
        data <- map["data"]
        
    }
}
