//
//  APIService.swift
//  ShareExtention
//
//  Created by Dinh Dai on 12/11/19.
//  Copyright © 2019 VivaVietNam. All rights reserved.abc
//

import Foundation
import Alamofire
import UIKit

enum MethodApiExtension
{
    case PostApi
    case GetApi
    case PutApi
    case DeleteApi
    case OptionsApi
}

open class APIService {
    static let sharedInstance = APIService()
    typealias CompletionHandler = (_ response: [String: Any]) -> Void
    typealias ErrorHandler = (_ response: Error) -> Void
    
    func httpRequestAPI(url:String,params:[String:Any],isHeader:Bool? = false, headerXtra: [String:String]? = nil,meThod:MethodApiExtension,completionHandler: @escaping CompletionHandler,failure:@escaping ErrorHandler) {
        var headers = HTTPHeaders()
        if !isHeader! {
            headers["Accept"] = "application/json"
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        }
        if let head = headerXtra {
            for (key,value) in head {
                headers[key] = value
            }
        }
        if meThod == .PostApi {
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if response.result.value != nil, let json = JSON as? [String: Any]{
                        completionHandler (json)
                    }
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
            }
            
            
        }else if meThod == .GetApi {
            
            
            Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if response.result.value != nil, let json = JSON as? [String: Any]{
                        completionHandler (json)
                    }
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
            }
        }else if meThod == .PutApi {
            Alamofire.request(url, method: .put, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if response.result.value != nil, let json = JSON as? [String: Any]{
                        completionHandler (json)
                    }
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
            }
        } else if meThod == .DeleteApi {
            Alamofire.request(url, method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if response.result.value != nil, let json = JSON as? [String: Any]{
                        
                        completionHandler (json)
                    }
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
            }
        } else if meThod == .OptionsApi{
            Alamofire.request(url, method: .options, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let JSON):
                    if response.result.value != nil, let json = JSON as? [String: Any]{
                        completionHandler (json)
                    }
                    break
                    
                case .failure(let error):
                    failure(error)
                    break
                }
            }
        }
    }
    
    func uploadImage(endUrl: String, imagedata: Data?, parameters: [String : Any], onCompletion: (([String: Any]) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let url = endUrl
        
        
        let headers: HTTPHeaders = [
            
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imagedata{
                multipartFormData.append(data, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
            }
            
        }, to:url,method: .post,headers: headers)
        { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch(response.result) {
                    case .success(let JSON):
                        if response.result.value != nil, let json = JSON as? [String: Any]{
                            onCompletion?(json)
                        }
                        break
                        
                    case .failure(let error):
                        onError?(error)
                        break
                    }
                }
            case .failure(let error):
                //print("Error in upload: \(error.localizedDescription)")
                onError?(error)
                
            }
            
        }
    }

}
