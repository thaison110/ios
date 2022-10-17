//
//  ActivateModel.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit
import ObjectMapper
class ActivateModel: NSObject , Mappable{
    var note : String = ""
    var time : String = ""
    var title : String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        note <- map["note"]
        time <- map["time"]
        title <- map["title"]
       
    }
}

class NewsModel: NSObject , Mappable{
    var created_by : String = ""
    var id : Int?
    var image : String = ""
    var name : String = ""
    var time : Int64 = 0
    var type : Int?
    var is_important:Int?
    var detail:String?
    var height:CGFloat?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        created_by <- map["created_by"]
        id <- map["id"]
        image <- map["image"]
        name <- map["name"]
        time <- map["time"]
        type <- map["type"]
        is_important <- map["is_important"]
        detail <- map["detail"]
        
        self.detail = "<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\"><meta name=\"MobileOptimized\" content=\"100\"><style>img{width:100%;}body{font-family: 'Arial';font-size : 15px;min-height: 100%;overflow: auto;}body p{display: block;margin:0px; line-height: 140%;}div{display: block;position: static;font-size:15px;a{font-size:15px !importaint;}}</style></head><body>" + (detail ?? "") + "</body>"
    }
}

class DetailNewsModel: NSObject , Mappable{

    var name : String = ""
    var detail : String?
    var height:CGFloat?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        detail <- map["detail"]
        self.detail = "<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\"><meta name=\"MobileOptimized\" content=\"100\"><style>img{width:100%;}body{font-family: 'Arial';font-size : 15px;min-height: 100%;overflow: auto;}body p{display: block;margin:0px; line-height: 140%;}div{display: block;position: static;font-size:15px;a{font-size:15px !importaint;}}</style></head><body>" + (detail ?? "") + "</body>"
    }
}
