//
//  ShuttlePersonModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 21/09/2022.
//

import UIKit
import ObjectMapper

class ShuttlePersonModel: NSObject, Mappable {
    var created_at : Int64?
    var image : String = ""
    var name : String = ""
    var relationship : Int?
    var tel : String = ""
    var id: Int?
  
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        created_at <- map["created_at"]
        image <- map["image"]
        name <- map["name"]
        tel <- map["tel"]
        relationship <- map["relationship"]
        id <- map["id"]
       
    }
}
