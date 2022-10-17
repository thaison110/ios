//
//  HistoryPickUpModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 22/09/2022.
//

import UIKit
import ObjectMapper


class HistoryPickUpModel: NSObject, Mappable {
    var created_at : Int64?
    var date : String = ""
    var homie_name : String = ""
    var hour : String = ""
    var note : String = ""
    var relationship: String = ""
    var status: Int?
    var type: Int?
  
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        created_at <- map["created_at"]
        date <- map["date"]
        homie_name <- map["homie_name"]
        hour <- map["hour"]
        note <- map["note"]
        relationship <- map["relationship"]
        status <- map["status"]
        type <- map["type"]
    }
}
