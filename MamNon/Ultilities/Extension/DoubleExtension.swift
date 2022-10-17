//
//  DoubleExtension.swift
//  MamNon
//
//  Created by Ngo Thuy on 18/09/2022.
//

import Foundation
public extension Double {
    
    func convertToDate() ->Date {
        let date = Date(timeIntervalSince1970: self)
        
        return date
    }
    
    
    
    func timeLeftDisplay() -> String{
        let timeLeft = Date().timeIntervalSince1970 - self
        if timeLeft > 31536000 {
            return "\(Int(timeLeft/31536000)) năm"
        }
        else if timeLeft > 2592000 {
            return "\(Int(timeLeft/2592000)) tháng"
        }
        else if timeLeft > 2592000 {
            return "\(Int(timeLeft/2592000)) tháng"
        }
        else if timeLeft > 86400 {
            return "\(Int(timeLeft/86400)) ngày"
        }
        else if timeLeft > 86400 {
            return "\(Int(timeLeft/3600)) giờ"
        }
        else if timeLeft > 60 {
            return "\(Int(timeLeft/60)) phút"
        }
        else if timeLeft > 0 {
            return "\(Int(timeLeft)) giây"
        }
        return "0"
    }
    
    func convertToTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertToTimeDayMonthYear() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertToDateBlog() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd,MM,yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
   
    
    func convertToDateWidgetDDMMYY() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    func convertToShortDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertToShortDateAndTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-yy HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    func convertToDay() -> String {
        let date = Date(timeIntervalSince1970: self)
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        
        if weekDay == 1 {
            return "CN"
        }
        
        return "T\(weekDay)"
    }
    
}
