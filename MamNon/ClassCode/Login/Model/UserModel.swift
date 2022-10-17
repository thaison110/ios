//
//  User.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit
import ObjectMapper

class UserModel: NSObject,Mappable {
    var address : String = ""
    var avatar : String = ""
    var birthday : String = ""
    var Class : String = ""
    var email : String = ""
    var fullname : String = ""
    var gender : Int?
    var id : Int?
    var nickname : String = ""
    var parent_birthday : String = ""
    var parent_name : String = ""
    var tel : String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        avatar <- map["avatar"]
        birthday <- map["birthday"]
        Class <- map["class"]
        email <- map["email"]
        fullname <- map["fullname"]
        gender <- map["gender"]
        id <- map["id"]
        nickname <- map["nickname"]
        parent_birthday <- map["parent_birthday"]
        parent_name <- map["parent_name"]
        tel <- map["tel"]
       
    }
}


class UserInforModel: NSObject,Mappable {
    var user_info : UserModel?
    var news : [NewsModel] = []
    var activate : [ActivateModel] = []
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user_info <- map["user_info"]
        news <- map["news"]
        activate <- map["activate"]
       
       
    }
}
