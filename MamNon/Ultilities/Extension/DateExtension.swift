//
//  DateExtension.swift
//  HoM
//
//  Created by iAm2r on 1/9/21.
//  Copyright © 2021 iAm2r. All rights reserved.
//

import Foundation

 extension Date {
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

    func getPreviousMonth() -> Date? {
         return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
     
    func getPreviousOrNextMonth(value: Int) -> Date? {
          return Calendar.current.date(byAdding: .month, value: value, to: self)
    }
     
    func getPreviousOrNextDay(value: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: value, to: self)
    }
     
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
     
     func getMonthAndYear () -> String? { // 05,2020
         let calendar = Calendar.current
         let components = calendar.dateComponents([.month,.year], from: self)
         if let month = components.month , let year = components.year {
             let time = "\(month), \(year)"
            return time
         }
         return nil
     }
     
     func getDayMonthYearInt () -> (Int, Int, Int)? {
         let calendar = Calendar.current
         let components = calendar.dateComponents([.day,.month,.year], from: self)
         if let month = components.month , let year = components.year, let day = components.day {
           
            return (day, month, year)
         }
         return nil
     }
     
     func getTimeHHMMSS () -> (Int, Int,Int)? {
         let calendar = Calendar.current
         let components = calendar.dateComponents([.hour,.minute,.second], from: self)
         if let hour = components.hour , let minute = components.minute, let second = components.second {
           
            return (hour, minute, second)
         }
         return nil
     }
    
     func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            var time = ""
            if (diff > 0) {
                time = "\(diff) giây trước"
            } else if (diff == 0) {
                time = "vừa xong"
            } else {
                time = ""
            }
            return time
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) phút trước"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) giờ trước"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) ngày trước"
        }else if monthAgo < self {
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
            return "\(diff) tuần trước"
        }
//        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
//        return "\(diff) tuần trước"
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let day = df.string(from: self)
        return day
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    
     func toString()->String {
        let dayStr = self.dayLotus < 10 ? "0\(self.dayLotus)" : "\(self.dayLotus)"
        let monthStr = self.monthLotus < 10 ? "0\(self.monthLotus)" : "\(self.monthLotus)"
        return dayStr + "/" + monthStr + "/" + String(self.yearLotus)
    }
    
     func plusSeconds(_ s: UInt) -> Date {
        return self.addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func minusSeconds(_ s: UInt) -> Date {
        return self.addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func plusMinutes(_ m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func minusMinutes(_ m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func plusHours(_ h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func minusHours(_ h: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }
    
     func plusDays(_ d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }
    
     func minusDays(_ d: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }
    
     func plusWeeks(_ w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }
    
    public func minusWeeks(_ w: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }
    
     func plusMonths(_ m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }
    
     func minusMonths(_ m: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }
    
     func plusYears(_ y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }
    
     func minusYears(_ y: UInt) -> Date {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }
    
    fileprivate func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> Date {
        var dc: DateComponents = DateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return (Calendar.current as NSCalendar).date(byAdding: dc, to: self, options: [])!
    }
    
     func midnightUTCDate() -> Date {
        var dc: DateComponents = (Calendar.current as NSCalendar).components([.year, .month, .day], from: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        (dc as NSDateComponents).timeZone = TimeZone(secondsFromGMT: 0)
        
        return Calendar.current.date(from: dc)!
    }
    
     static func secondsBetween(date1 d1:Date, date2 d2:Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.second, from: d1, to: d2, options:[])
        return dc.second!
    }
    
    public static func minutesBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: d1, to: d2, options: [])
        return dc.minute!
    }
    
    public static func hoursBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.hour, from: d1, to: d2, options: [])
        return dc.hour!
    }
    
    public static func daysBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: d1, to: d2, options: [])
        return dc.day!
    }
    
    public static func weeksBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.weekOfYear, from: d1, to: d2, options: [])
        return dc.weekOfYear!
    }
    
    public static func monthsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: d1, to: d2, options: [])
        return dc.month!
    }
    
    public static func yearsBetween(date1 d1: Date, date2 d2: Date) -> Int {
        let dc = (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: d1, to: d2, options: [])
        return dc.year!
    }
    
    //MARK- Comparison Methods
    
    public func isAfter(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }
    
    public func isBefore(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }
    
    //MARK- Computed Properties
    
    public var dayLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.day, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.day
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.day!)
        }
    }
    
    public var monthLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.month, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.month
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.month!)
        }
    }
    
    public var yearLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.year, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.year
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.year!)
        }
    }
    
    public var hourLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.hour, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.hour
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.hour!)
        }
    }
    
    public var minuteLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.minute, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.minute
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.minute!)
        }
    }
    
    public var secondLotus: UInt {
        if #available(iOS 8.0, *) {
            return UInt((Calendar.current as NSCalendar).component(.second, from: self))
        } else {
            // Fallback on earlier versions
            let flags: NSCalendar.Unit = NSCalendar.Unit.second
            let date = Date()
            let components = (Calendar.current as NSCalendar).components(flags, from: date)
            return UInt(components.second!)
        }
    }
}
