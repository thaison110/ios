//
//  Ultilities.swift
//  tuetam
//
//  Created by Dinh Dai on 4/2/21.
//

import UIKit

class Utilities{
    class func calculateTextHeightNumberLine(numberLines: Int, text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        lb.numberOfLines = numberLines
        lb.text = text
        lb.font = font
        lb.sizeToFit()
        return lb.frame.size.height
    }
    
    class func calculateTextHeight(_ text: String, font: UIFont, width: CGFloat) -> CGFloat {
        if text.count == 0 {
            return 0
        }
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        lb.numberOfLines = 0
        lb.text = text
        lb.font = font
        lb.sizeToFit()
        return lb.frame.size.height
    }
    
    class func calculateTextWidth(_ text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        lb.numberOfLines = 0
        lb.text = text
        lb.font = font
        lb.sizeToFit()
        return lb.frame.size.width
    }
    
    class func getCurrentTimestamp() -> Int {
            let now = Date().timeIntervalSince1970
            return Int(now)
    }
    
    class func formatNumberSmallerTen(number:Int) -> String{
        if number < 10{
            return String(format: "0%d", number)
        }
        return String(format: "%d", number)
    }
    
    class func convertDurationToTimeFormat(duration:Float) -> String{
        
        if duration < 3600{
            let mins:Int = Int(duration/60)
            let second:Int = Int(duration) - mins*60
            return String(format: "%@:%@", self.formatNumberSmallerTen(number: mins), self.formatNumberSmallerTen(number: second))
        }
        else {
            let hours:Int = Int(duration/3600)
            let mins:Int = (Int(duration) - hours*3600)/60
            let second = Int(duration) - hours*3600 - mins*60
            return String(format: "%@:%@:%@", self.formatNumberSmallerTen(number: hours), self.formatNumberSmallerTen(number: mins), self.formatNumberSmallerTen(number: second))
        }
    }
    
    
    class func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
}
