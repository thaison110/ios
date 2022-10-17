//
//  HomeModel.swift
//  MamNon
//
//  Created by Thắng Trương on 19/09/2022.
//

import UIKit

class HomeModel: NSObject {
    var user_info : UserModel?
    var news : [NewsModel]?
    var activate : [ActivateModel]?
    var typeHome:TypeHome?
    var arrayFeaturePin :[TypeFeature] = [.Empty,.Empty,.Empty]
    var titleHeader:String?
    var titleButton:String?
}
