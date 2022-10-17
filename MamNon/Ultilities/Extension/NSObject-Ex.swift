//
//  NSObject-Ex.swift
//  HoM
//
//  Created by Nguyen Tien on 10/12/20.
//  Copyright © 2020 iAm2r. All rights reserved.
//

import Foundation
import ObjectMapper

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
