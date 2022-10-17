//
//  MessageService.swift
//  MamNon
//
//  Created by Ngo Thuy on 17/09/2022.
//

import Foundation
class MessageService{
    func getListTeacher(_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.getListTeacher

    
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
    
    func sendChatMessage(_ teacher_id : Int,message : String, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.sendMessage

    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"  + "teacher_id\(teacher_id)"   + "message" + message 

        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            "message":message,
            "teacher_id":teacher_id,
            "time": time
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
    
    func getHistoryMessage(_ teacher_id : Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.history

    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"  + "teacher_id\(teacher_id)"

        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            "teacher_id":teacher_id,
            "time": time
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
