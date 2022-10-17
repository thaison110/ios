//
//  ImageLibraryModel.swift
//  KHFooterSwift
//
//  Created by Ngô Thuỷ on 12/21/18.
//  Copyright © 2018 Ngo Thuy. All rights reserved.
//

import UIKit
import Photos

class ImageLibraryModel: NSObject {
    var image : UIImage?
    var type: String = ""
    var duration : String = ""
    var asset : PHAsset?
    var indexChoicedImage : Int = 0
    var isCheckCellActive  = false
    var link : String = ""
    var linkThumb: String = ""
    var textPost:String = ""
    var isTopMedia = 0
    var localUrl: URL?
    var ext : String = ""
    
    override init() {
        
    }
    init(image:UIImage, type:String, duration:String) {
        self.image = image
        self.type = type
        self.duration = duration
    }
    
    func setData(image:UIImage, type:String, duration:String) {
        self.image = image
        self.type = type
        self.duration = duration
    }
    
    func getLinkMediaAsset()  {
        if let asset = self.asset {
            HandleImageAndVideo.getURL(ofPhotoWith: asset) { url in
                if let link = url?.path {
                    self.link = link
                }
            }
        }
        
    }
    func getSize()->Int64{
        let resources = PHAssetResource.assetResources(for: self.asset!) // your PHAsset
        
        var sizeOnDisk: Int64? = 0
        
        if let resource = resources.first {
            let unsignedInt64 = resource.value(forKey: "fileSize") as? CLong
            sizeOnDisk = Int64(bitPattern: UInt64(unsignedInt64!))
//            print("this is length \(sizeOnDisk)")
            return sizeOnDisk ?? 0
        }
        return 0
        
    }
    
    /// checkSize
    ///
    /// - Returns: value valid of size
    func checkSize()-> Bool{
        let size : Int64 = self.getSize()
        let sizeByMB : Double = Double(size)/1000000.0
        if(self.asset!.mediaType.rawValue == PHAssetMediaType.image.rawValue){
            return 15.0 >= sizeByMB
        }else if(self.asset!.mediaType.rawValue == PHAssetMediaType.video.rawValue){
            return 300 >= sizeByMB
        }
        return false
    }
    
    func getImageFormAsset()  {
        let imgManager=PHImageManager.default()
        let requestOptions=PHImageRequestOptions()
        requestOptions.isSynchronous=true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        
       
        
        
        if(asset!.mediaType.rawValue == PHAssetMediaType.image.rawValue){ // nếu là ảnh

            imgManager.requestImage(for:self.asset!, targetSize: CGSize(width:400, height: 400),contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, error) in

                self.image = image
                self.type = "Image"
                
            })
        }else{
            
            imgManager.requestImage(for: self.asset!, targetSize: CGSize(width:400, height: 400),contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, error) in           
                self.image = image
                self.type = "Video"
                self.duration = String(format: "%02d:%02d",Int((self.asset!.duration / 60)),Int(self.asset!.duration) % 60)
                
            })
            
            
        }
    }
}
