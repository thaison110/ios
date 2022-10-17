//
//  MedicineService.swift
//  MamNon
//
//  Created by Ngo Thuy on 29/09/2022.
//

import UIKit

class MedicineService: NSObject {
    func sendMedicine(_ note: String,date_start: String,date_end: String, images: [String], completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.MedicineSend
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "date_start" + date_start + "date_end" + date_end + "detail" + "note" + note
        let md5 = checksum.md5
        var params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "time":time,
            "note":note,
            "date_start": date_start,
            "date_end": date_end,
            "detail":""
            
              ] as [String:Any]
        if let image = Common.json(from: images) {
            params["images"] = image
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
    
    func getMedicineHistory(_ completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.MedicineHistory
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)"
        let md5 = checksum.md5
        var params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "time":time,
            
            
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
    
    func deleteMedicine(_ id: Int,  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.MedicineDelete
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "id\(id)"
        let md5 = checksum.md5
        var params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "time":time,
            "note": "",
            "id": id
            
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
