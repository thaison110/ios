//
//  LeaveService.swift
//  MamNon
//
//  Created by Truong Thang on 23/09/2022.
//

import Foundation


class LeaveService: NSObject {

    func getDataHistoryLeaveLearn(_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.GetHistoryLeaveLearn
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
              "time":time
              ] as [String:Any]
        APIService.sharedInstance.httpRequestAPI(url: url, params: params, meThod: .PostApi, completionHandler: { (response) in
            if let responseModel = MetaResponse(JSON: response){
                
                completionHandler(response)
            } else {
                failure("Error")
            }
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
    
    func getSendDataLeave(note:String,dates:String,_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.SendLeaveLearn
        
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "dates\(dates)" + "note\(note)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token,
            "checksum":md5,
            "time":time,
            "note":note,
            "dates":dates
        ] as [String:Any]
        APIService.sharedInstance.httpRequestAPI(url: url, params: params, meThod: .PostApi, completionHandler: { (response) in
            if let responseModel = MetaResponse(JSON: response){
                
                completionHandler(response)
            } else {
                failure("Error")
            }
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
    
    
    func getDataActiveDay(date:String,_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.GetActiveDate
        
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "date\(date)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            "time":time,
            "date":date
        ] as [String:Any]
        APIService.sharedInstance.httpRequestAPI(url: url, params: params, meThod: .PostApi, completionHandler: { (response) in
            if let responseModel = MetaResponse(JSON: response){
                
                completionHandler(response)
            } else {
                failure("Error")
            }
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
    
}
