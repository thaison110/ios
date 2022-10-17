//
//  ChatPersonModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 17/09/2022.
//

import UIKit
import ObjectMapper



class ChatPersonModel: NSObject,Mappable {
   
    var avatar : String = ""
    var id : Int?
    var name : String = ""
    var sort : Int = 0
    var text_last : String = ""
    var time_last : Int64?
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        avatar <- map["avatar"]
        name <- map["name"]
        sort <- map["sort"]
        time_last <- map["time_last"]
        text_last <- map["text_last"]
       
    }
}
