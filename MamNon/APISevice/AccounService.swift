//
//  AccounService.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import Foundation
import CommonCrypto

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
class AccounService{
    func loginUser(_ userName: String, passWord: String , completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.login
        
        
//        let data = [
//              "username":userName,
//              "password":passWord,
//              "time":time
//              ] as [String:Any]
        
        let checksum = codeCheckSum + "username" + userName + "password" + passWord + "time\(time)"
        let md5 = checksum.md5
        let params = [
              "username":userName,
              "password":passWord,
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
    
    func getInforAccount(_  completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.getInfo
    
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
    
    func changePassWord(_ password: String, password_new : String, password_new_retype : String, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.ChangePassword
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "password" +  password + "password_new" +  password_new + "password_new_retype" +  password_new_retype
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
              "time":time,
            "password_new": password_new,
            "password": password,
            "password_new_retype" : password_new_retype
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
    
    func updateInforStudent(_ name: String,nickname:String, image : String, birthday : String,gender:Int, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.ChangeInfoStudent
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "name" +  name + "nickname" +  nickname + "birthday" +  birthday + "gender\(gender)"
        let md5 = checksum.md5
        var params = [
            "token":GlobalData.sharedInstance.token ,
              "checksum":md5,
              "time":time,
            "name": name,
            "nickname": nickname,
            "birthday" : birthday,
            "gender": gender
              ] as [String:Any]
        if image.count > 0 {
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
    
    func updateInforParent(_ name: String,birthDay:String, address : String, email : String,phone:String, completionHandler: @escaping ([String: Any])->(),failure:@escaping (String)->()) {
        let time = Utilities.getCurrentTimestamp()
        let url = Domain.ChangeInfoParent
    
        let checksum = codeCheckSum + "token" + GlobalData.sharedInstance.token  + "time\(time)" + "parent_name\(name)" + "parent_birthday\(birthDay)" + "tel\(phone)" + "address\(address)" + "email\(email)"
        let md5 = checksum.md5
        let params = [
            "token":GlobalData.sharedInstance.token ,
            "checksum":md5,
            "time":time,
            "parent_name": name,
            "parent_birthday": birthDay,
            "tel" : phone,
            "address": address,
            "email":email
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
