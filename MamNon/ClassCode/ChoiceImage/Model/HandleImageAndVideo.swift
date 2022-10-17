//
//  HandleImageAndVideo.swift
//  KingHub
//
//  Created by Ngô Thuỷ on 3/12/19.
//  Copyright © 2019 VivaVietNam. All rights reserved.
//

import UIKit
import Photos

class HandleImageAndVideo: NSObject {
    static func getURL(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ responseURL : URL?) -> Void)) {
        
        if mPhasset.mediaType == .image {
//            let options = PHImageRequestOptions()
//            options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
//            options.isSynchronous = false
//            options.isNetworkAccessAllowed = true
//            options.deliveryMode = .opportunistic
//            options.version = .current
//            options.resizeMode = .exact
//            PHImageManager.default().requestImageData(for: mPhasset, options: options) { (data, string, orientation, info) in
//                if let fileUrl = info?["PHImageFileURLKey"] as? URL {
////                    let url = URL(fileURLWithPath: fileUrl)
//                    completionHandler(fileUrl)
//                }
//                else{
//                    completionHandler(nil)
//                }
//            }
//
            
            
            
            
            
            // cũ ko lấy dc ảnh khi bị edit
            
//            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
//            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
//                return true
//            }
//            mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
//                if contentEditingInput != nil {
//                        completionHandler(contentEditingInput!.fullSizeImageURL)
//                }else{
//                    completionHandler(URL(string: ""))
//                }
//
//            })
//
            
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.isNetworkAccessAllowed = true
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return false
            }
            
            mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                guard let url = contentEditingInput?.fullSizeImageURL else {
//                    observer.onError(PHAssetError.imageRequestFailed)
                        completionHandler(URL(string: ""))
                    return
                }
                completionHandler(url)
                /// Using this `url`
            })
            
            


        } else if mPhasset.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            options.isNetworkAccessAllowed=true //iCloud video can play
            PHImageManager.default().requestAVAsset(forVideo: mPhasset, options: options, resultHandler: { (asset, audioMix, info) in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl = urlAsset.url
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
        
    }
    
    static func getURLForSend(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ responseURL : URL? , _ mimeType : String?) -> Void)) {
        if mPhasset.mediaType == .image {
            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
            options.isNetworkAccessAllowed = true
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return false
            }
            mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                
                guard let url = contentEditingInput?.fullSizeImageURL,let uniformTypeIdentifier = contentEditingInput?.uniformTypeIdentifier else {
                    //                    observer.onError(PHAssetError.imageRequestFailed)
                    completionHandler(nil, nil)
                    return
                }
                
                completionHandler(url, uniformTypeIdentifier)
                /// Using this `url`
            })
        } else if mPhasset.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            options.isNetworkAccessAllowed=true //iCloud video can play
            PHImageManager.default().requestAVAsset(forVideo: mPhasset, options: options, resultHandler: { (asset, audioMix, info) in
                guard let urlAsset = asset as? AVURLAsset else {
                    //                    observer.onError(PHAssetError.imageRequestFailed)
                    completionHandler(nil, nil)
                    return
                }
                let localVideoUrl = urlAsset.url
                completionHandler(localVideoUrl, urlAsset.url.pathExtension)
            })
        }
    }
    
    func convertImageToData(image :UIImage) -> NSData{
        return   (image.pngData() as NSData?)!
    }
    
    func  convertVideoToData(link:String) -> NSData {
//        return  NSData.dataWithContentsOfMappedFile(link) as! NSData
        let data  = NSData(contentsOf: URL(string: link)!)
        return data!
        
    }
    
    
    // save và dọc ảnh
  
    static func saveImage(imageName: String, image: UIImage) -> String {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return ""}
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return ""}
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
                
            } catch let removeError {
                print("couldn't remove file at path", removeError)
                
            }
            
        }
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch let error {
            print("error saving file with error", error)
            return ""
        }
        
    }
    
    // đọc ảnh trong bộ nhớ
    static func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }

    
    // save video
    
    static func saveVideoAsset(identifiers: String) -> (URL?,String?) {
        
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: [identifiers], options: nil)
        if assets.count > 0 {
            let asset = assets.firstObject as! PHAsset
            
            // bắt đầu từ điểm thay lấy url video từ doccomment
            let resources = PHAssetResource.assetResources(for: asset)
            guard resources.count > 0 else { return (nil, nil)  }
            //            let resource = resources[0]
                        //Filter video hiện tại
                        
            let assetTypeFilterList: [PHAssetResourceType] = [.video, .fullSizeVideo]
            let resource = resources.first(where: { $0.value(forKey: "isCurrent") as? Bool == true
                                            && assetTypeFilterList.contains($0.type)}) ?? resources[0]
            let originalName = resources[0].originalFilename
            
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentUrl = urls[0]
            let resourceUrl = documentUrl.appendingPathComponent(originalName, isDirectory: false)
            
            print("resourceURL \(resourceUrl)")
            print("resourceURL iden \(identifiers)") 
            // write image
            let options = PHAssetResourceRequestOptions()
            options.isNetworkAccessAllowed = true
            
            if !FileManager.default.fileExists(atPath: resourceUrl.path) {
                var link : URL?
                var type : String?
                let group = DispatchGroup()
                group.enter()
                PHAssetResourceManager.default().writeData(for: resource, toFile: resourceUrl, options: options) { error in
                    if error == nil {
                        //                        urlAsset.url.pathExtension
                        link = resourceUrl
                        type = resourceUrl.pathExtension
                        group.leave()
                        
                    }
                    
                }
                group.wait()
                print("resourceURL2 \(link)")
                return (link, type)
            } else {
                print("resourceURL3 \(resourceUrl)")
                return (resourceUrl, resourceUrl.pathExtension)
            }
        }else{
            return (nil, nil)
        }
    }
    
   static func  removeFileInLocal(link: String)  {
        if FileManager.default.fileExists(atPath: link) {
            do {
                try FileManager.default.removeItem(atPath: link)
                print("Removed old image")
                
            } catch let removeError {
                print("couldn't remove file at path", removeError)
                
            }
            
        }
    }
    
    static func removeFileVideoassetInLocal(identifiers: String)  {
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: [identifiers], options: nil)
        if assets.count > 0 {
            let asset = assets.firstObject as! PHAsset
            
            // bắt đầu từ điểm thay lấy url video từ doccomment
            let resources = PHAssetResource.assetResources(for: asset)
            guard resources.count > 0 else { return  }
            let resource = resources[0]
            
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentUrl = urls[0]
            let resourceUrl = documentUrl.appendingPathComponent(resource.originalFilename, isDirectory: false)
            var link = resourceUrl.path
            if FileManager.default.fileExists(atPath:link) {
                do {
                    try FileManager.default.removeItem(atPath: link)
                    print("Removed old image")
                    
                } catch let removeError {
                    print("couldn't remove file at path", removeError)
                    
                }
                
            }
            
        }
        
    }
    
    
    static func saveVideoUrlToDocumment(link:String) -> String {
        
        let manager = FileManager.default
        let documentsDirectory = manager.urls(for: .documentDirectory, in: .userDomainMask).last!
         let now = Date().timeIntervalSince1970
        let docVideoURL = documentsDirectory.appendingPathComponent("selectedLibraryVideo\(now).MOV")
        let docVideoPath = docVideoURL.path
        
        do {
            if manager.fileExists(atPath: docVideoPath) {
                try manager.removeItem(atPath: docVideoPath)
            }
//            try manager.moveItem(atPath: link, toPath: docVideoPath)
           try manager.copyItem(atPath: link, toPath: docVideoPath)
        }
        catch {
            print(error)
        }
        return docVideoPath
    }
        
}
