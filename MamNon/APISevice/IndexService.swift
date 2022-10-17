//
//  IndexService.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit

class IndexService: NSObject {
    func getDataHealth(_ year: Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.GetHealth
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "year\(year)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
            "time":time,
            "year":year
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
