//
//  LeaveModel.swift
//  MamNon
//
//  Created by Truong Thang on 23/09/2022.
//

import UIKit
import ObjectMapper

class LeaveModel: NSObject , Mappable{
    var createdAt : Double = 0
    var note : String = ""
    var dates : String = ""
    var status:Int = 0 {
        didSet {
            if status == 0 {
                self.statusString = "Chờ xác nhận"
            }else {
                self.statusString = "Đã xác nhận"
            }
        }
    }
    var statusString = "Đã xác nhận"
    var datesArr:[String] = []

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        createdAt <- map["created_at"]
        note <- map["note"]
        dates <- map["dates"]
        status <- map["status"]
        datesArr = dates.components(separatedBy: ",")
    }
}

