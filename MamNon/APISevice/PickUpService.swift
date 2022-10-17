//
//  PickUpService.swift
//  MamNon
//
//  Created by Ngo Thuy on 21/09/2022.
//

import Foundation
class PickUpService {
    func addPersonPickUp(_ name : String,image:String,relationship: Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.PickUpCreatePerson
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"  + "name" + name
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "name":name,
            "note":"",
            "tel":"",
            "image": image,
            "time": time,
            "relationship": relationship
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
    
    func getListPersonPickUp(_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.ListPickUpPerson
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
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
    
    func createPickUp(_ note : String,type:Int,date: String, hour: String, homie_id: Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.SendPickup
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"  + "type\(type)" + "date" + date + "hour" + hour + "homie_id\(homie_id)" + "note" + note
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            "type":type,
            "note":note,
            "date": date,
            "time": time,
            "homie_id": homie_id,
            "hour":hour
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
    
    
    func getHistoryPickUp(_ completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.getListHistory
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            
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
    
    
    func deletePersonPickUp(_ id: Int,completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.DeletePersonPickUp
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "id\(id)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            
            "time": time,
            "id":id,
            "note":""
           
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
    
    
    func editPersonPickUp(_ name : String,image:String?,relationship: Int,id: Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.EditPickup
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"  + "name" + name + "id\(id)"
        let md5 = checksum.md5
        var params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "name":name,
            "note":"",
            "tel":"",
            
            "time": time,
            "relationship": relationship,
            "id":id
              ] as [String:Any]
        
        if let image = image {
            params["image"] = image
        }
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
