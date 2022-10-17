//
//  MessgerChatModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 18/09/2022.
//

import UIKit
import ObjectMapper

class MessageChatModel: NSObject, Mappable {
    var detail : String = ""
    var sender_id : Int?
  
    var time : Int64 = 0
   
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        detail <- map["detail"]
        sender_id <- map["sender_id"]
        time <- map["time"]
       
    }
}
