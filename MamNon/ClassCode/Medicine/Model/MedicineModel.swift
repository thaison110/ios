//
//  MedicineModel.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 30/09/2022.
//

import UIKit
import ObjectMapper

class MedicineModel: NSObject,Mappable {
   
    var created_at : Int64?
    var date_end : Int64?
    var date_start : Int64?
    var id : Int?
    var detail : String = ""
    var image : [String] = []
    var note : String = ""
    var status : Int?
    var teacher_confirm: String?
  

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        date_end <- map["date_end"]
        date_start <- map["date_start"]
        detail <- map["detail"]
        image <- map["image"]
        note <- map["note"]
        status <- map["status"]
        teacher_confirm <- map["teacher_confirm"]
    }
}
