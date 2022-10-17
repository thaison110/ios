//
//  HandleMediaPicker.swift
//  KingHub
//
//  Created by Dinh Dai on 11/02/2022.
//  Copyright © 2022 VivaVietNam. All rights reserved.
//

import Foundation
import Photos

class HandleMediaPicker : NSObject {
    func requestPermission(rootVC: UIViewController?, completionBlock:@escaping () -> Void){
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    DispatchQueue.main.async {
                        completionBlock()
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Quyền truy cập thư viện bị từ chối", message: "Ứng dụng cần quyền truy cập thư viện", preferredStyle: .alert)
                        alert.addAction(UIAlertAction (title: "Đồng ý", style: .default, handler: { (action) in
                            UIApplication.shared.open(URL (string: UIApplication.openSettingsURLString)!)
                        }))
                        rootVC?.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else if photos == .authorized {
            DispatchQueue.main.async {
                completionBlock()
            }
        }
        else if photos == .denied{
            let alert = UIAlertController(title: "Quyền truy cập thư viện bị từ chối", message: "Ứng dụng cần quyền truy cập thư viện", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "Đồng ý", style: .default, handler: { (action) in
                UIApplication.shared.open(URL (string: UIApplication.openSettingsURLString)!)
            }))
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
}
