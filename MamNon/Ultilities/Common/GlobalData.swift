//
//  GlobalData.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit
import Foundation

class GlobalData: NSObject {
    static var sharedInstance: GlobalData = GlobalData()
    var token: String = ""
    var userLogin : UserModel?
    var userInfor : UserInforModel?
    var arrayFeaturePin :[TypeFeature] = []
}
