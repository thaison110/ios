//
//  ChoiceImageViewModel.swift
//  KHFooterSwift
//
//  Created by Ngô Thuỷ on 12/21/18.
//  Copyright © 2018 Ngo Thuy. All rights reserved.
//

import Foundation
import Photos

public class ChoiceImageViewModel{
    func GetListAlbums() ->[AlbumModel]{
        var album:[AlbumModel] = [AlbumModel]()
        
      
        let options = PHFetchOptions()
        album = []
        //        options.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        let albumsPhoto:PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
        
        albumsPhoto.enumerateObjects({(collection, index, object) in
            let photoInAlbum = PHAsset.fetchAssets(in: collection, options: nil)
//            print(photoInAlbum.count)
//            print(collection.localizedTitle)
            if(photoInAlbum.count > 0){
                let newAlbum = AlbumModel(name: collection.localizedTitle!, count: photoInAlbum.count, collection:collection)
                album.append(newAlbum)
            }
            
        })
        return album
        
//        for item in album {
//            print(item)
//            if(item.name == "Camera Roll"){
//                //                fetchCustomAlbumPhotos1(nameAlbum:"Screenshots")
//                //                getPhotosAndVideos(nameAlbum:"Screenshots")
//                GetImageInAlbum(album: item.collection)
//
//            }
//        }
        
        
        
        
    }
    
    
    func GetImageInAlbum(album: PHAssetCollection) -> [ImageLibraryModel]{
        var arrayImage: [ImageLibraryModel] = []
        let assetsFetchOptions = PHFetchOptions()
        assetsFetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        assetsFetchOptions.predicate = NSPredicate(format: "mediaType = %d || mediaType = %d", PHAssetMediaType.image.rawValue, PHAssetMediaType.image.rawValue)

        
        let requestOptions=PHImageRequestOptions()
        requestOptions.isSynchronous=true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(in: album, options: assetsFetchOptions)
        
//        let imgManager=PHImageManager.default()
        
        if fetchResult.count > 0 {
            
            for i in 0..<fetchResult.count{
                let asset = fetchResult.object(at: i) as PHAsset
                let objImage : ImageLibraryModel = ImageLibraryModel.init()
                objImage.asset = asset
//                let assetId = asset.localIdentifier
//                if let assetX = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject {
//                    objImage.asset = assetX
//                }
//                else{
//                    print("")
//                }
                arrayImage.append(objImage)
                
                
//                if(asset.mediaType.rawValue == PHAssetMediaType.image.rawValue){ // nếu là ảnh
//                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:100, height: 100),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
////                        self.imageArray.append(image!)
//                        let objImage = ImageLibraryModel.init(image: image!, type: "Image", duration: "")
//                        arrayImage.append(objImage)
//                    })
//                }else{
//
//                    imgManager.requestImage(for: asset, targetSize: CGSize(width:100, height: 100),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
////                        self.imageArray.append(image!)
////                        print("duration: " + String(format: "%02d:%02d",Int((asset.duration / 60)),Int(asset.duration) % 60))
//                        let objImage = ImageLibraryModel.init(image: image!, type: "Video", duration: String(format: "%02d:%02d",Int((asset.duration / 60)),Int(asset.duration) % 60))
//                        arrayImage.append(objImage)
//
//                    })
//
//                }
                
                
                
            }
        } else {
            print("You got no photos.")
        }
        
        return arrayImage
        
      
    }
    
}


