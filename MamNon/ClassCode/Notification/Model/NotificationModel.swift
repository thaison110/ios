//
//  NotificationModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//



import UIKit
import ObjectMapper

class NotificationModel: NSObject, Mappable {
    var created_at : Int64?
    var date : Int64?
    var detail : String = ""
    var id : Int?
    var item_id: Int?
    var status : Int?
    var sender_name : String = ""
    var title : String = ""
    var type: Int?
  
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        created_at <- map["created_at"]
        date <- map["date"]
        detail <- map["detail"]
        id <- map["id"]
        item_id <- map["item_id"]
        status <- map["status"]
        sender_name <- map["sender_name"]
        title <- map["title"]
        type <- map["type"]
    }
}
