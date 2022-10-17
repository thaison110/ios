//
//  IntExtension.swift
//  KingHub
//
//  Created by iAm2r on 12/12/18.
//  Copyright © 2018 VivaVietNam. All rights reserved.
//

import Foundation

public extension Float {
    var kmFormatted : String {
        
        if self == 0 {
            return "0"
        }
        else if self < 1000 {
            let str = String(format: "%.0f", self)
            return str
        }
        else if self >= 1000, self <= 9999 {
            let str = String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        else if self >= 10000, self <= 99999 {
            let str = String(format: "%.0fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        else if self >= 100000, self <= 109000 {
            let format =  self/1000
            return String(format: "%.0fK",format)
        }
        else if self >= 109000, self <= 999999 {
            let format =  self/1000
            return String(format: "%.2fK",format)
        }
        else if self >= 1000000, self <= 1090000 {
            let format =  self/1000
            return String(format: "%.0fK",format)
        }
        else if self > 1000000 {
            let format =  self/1000000
            return String(format: "%.1fM",format)
        }
        return String(self)
    }
    
    var kmFormattedView : String {
        
        if self == 0 {
            return "0"
        }
        
        if self < 1000 {
            let str = String(format: "%.0f", self)
            return str
        }
        
        if self >= 1000, self <= 99999 {
            let str = String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        
        if self >= 100000, self <= 999999 {
            let format =  self/1000
            return String(format: "%.1fK",format)
        }
        
        if self > 999999 {
            let format =  self/1000000
            return String(format: "%.2fM",format)
        }
        return String(self)
    }
}


public extension Double {
    var kmFormatted : String {
        
        if self == 0 {
            return "0.0"
        }
        else if self < 1000 {
            let str = String(format: "%.1f", self)
            return str
        }
        else if self >= 1000, self <= 9999 {
            let str = String(format: "%.1fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        else if self >= 10000, self <= 99999 {
            let str = String(format: "%.0fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        else if self >= 100000, self <= 109000 {
            let format =  self/1000
            return String(format: "%.0fK",format)
        }
        else if self >= 109000, self <= 999999 {
            let format =  self/1000
            return String(format: "%.2fK",format)
        }
        else if self >= 1000000, self <= 1090000 {
            let format =  self/1000
            return String(format: "%.0fK",format)
        }
        else if self > 1000000 {
            let format =  self/1000000
            return String(format: "%.1fM",format)
        }
        return String(self)
    }
}

public extension Int {
    var kmFormatted: String {
        let number = Double(self)

        if self >= 1000, self <= 9999 {
            let str = String(format: "%.1fK", locale: Locale.current,number/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }

        if self >= 10000, self <= 99999 {
            let str = String(format: "%.0fK", locale: Locale.current,number/1000).replacingOccurrences(of: ".0", with: "")
            return str
        }
        
        if self >= 100000, self <= 999999 {
            let format =  self/1000
            return "\(format)K"
        }
        
        if self > 999999 {
            let format =  self/1000000
            return "\(format)M"
        }
        return String(self)
    }
}
