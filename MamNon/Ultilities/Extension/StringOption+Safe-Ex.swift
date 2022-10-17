//
//  StringOption+Safe.swift
//  HoM
//
//  Created by Nguyen Tien on 10/13/20.
//  Copyright © 2020 iAm2r. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var safe: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Bool {
    var safe: Bool {
        return self ?? false
    }
}

extension Optional where Wrapped == Int {
    var safe: Int {
        return self ?? 0
    }
}
/*

extension Optional where Wrapped: Collection {
    var safe: Collection {
        return self ?? []
    }
}
*/
