//
//  AlbumModel.swift
//  KHFooterSwift
//
//  Created by Ngô Thuỷ on 12/21/18.
//  Copyright © 2018 Ngo Thuy. All rights reserved.
//

import UIKit
import Photos

class AlbumModel: NSObject {
    let name:String
    let count:Int
    let collection:PHAssetCollection
    init(name:String, count:Int, collection:PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}
