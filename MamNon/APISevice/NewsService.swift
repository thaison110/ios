//
//  HomeService.swift
//  MamNon
//
//  Created by Thắng Trương on 19/09/2022.
//

import UIKit

class NewsService: NSObject {

    func getDataNews(_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.GetApiNews
    
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
    
    func getDataDetailNews(id:Int,_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.GetApiDetailNews
        
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "id\(id)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token,
            "checksum":md5,
            "time":time,
            "id":id
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
