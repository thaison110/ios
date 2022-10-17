//
//  Common.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import Foundation
import UIKit
import AVFoundation
class Common{
    
    static func setRootViewController(rootVC : UIViewController){
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
//            sceneDelegate.window!.rootViewController = rootVC
            if let window = sceneDelegate.window {
                window.rootViewController = rootVC
            }

        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window!.rootViewController = rootVC
            if let window = appDelegate.window {
                window.rootViewController = rootVC
            }

        }
    }
    
    static func getBottomPadding() -> CGFloat {
        if let window = UIApplication.shared.keyWindow {
            var bottomPadding: CGFloat = 0.0
            if #available(iOS 11.0, *) {
                bottomPadding  = window.safeAreaInsets.bottom
                
            }
            return bottomPadding
        }
        return 0
    }
    
    static func getTopPadding() -> CGFloat{
        if let window = UIApplication.shared.keyWindow {
            var topPadding: CGFloat = 0.0
            if #available(iOS 11.0, *) {
                topPadding  = window.safeAreaInsets.top
                
            }
            return topPadding
        }
        return 0
    }
    
    static func convertString(byObject object:Any) -> String?{
        guard let json = try? JSONSerialization.data(withJSONObject: object, options: []) else { return nil }
        if let string =  String(data: json, encoding: String.Encoding.utf8) {
            return string
        }
        else{
            return nil
        }
    }
    
    static func convertString(fromJsonObject string:String) -> [String:Any]? {
        if string.count == 0 {
            return nil
        }
        if let data = string.data(using: String.Encoding.utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                    return json
                }
            } catch {
            }
        }
        return nil
    }
    
    // lưu dic vào userDefault
    static func saveDataDictionaryToUserDefault(dic : [String:Any], key:String){
        UserDefaults.standard.set(dic, forKey: key)
            
    }
        
    //     đọc dic từ userDefault
    static func readDataDictionaryFromUserDefault( key:String) ->[String:Any]?{
        if let dic = UserDefaults.standard.object(forKey: key) as? [String : Any]{
            return dic
        }else{
            return nil
        }
    }
    
    static func saveArrayFeatureToUserDefault(array:[TypeFeature]){
        var arrayFeature : [String] = []
        for item in array{
            arrayFeature.append(item.rawValue)
        }
        UserDefaults.standard.set(arrayFeature, forKey: "ArrayTypeFeature")
    }
    //     đọc dic từ userDefault
    static func readArrayFeatureToUserDefault( ) -> [TypeFeature]{
        if let array = UserDefaults.standard.object(forKey: "ArrayTypeFeature") as? [String]{
            var arrayFeature : [TypeFeature] = []
            for item in array{
                arrayFeature.append(Common.convertStringToTypeFeature(type: item))
            }
            return arrayFeature
        }else{
            return []
        }
    }
    
    static func convertImageToBase64String (img: UIImage) -> String {
        
//        return  img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        let imageData = img.jpegData(compressionQuality: 0.9)
        return imageData!.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed) as! String
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func convertStringToTypeFeature(type : String) -> TypeFeature {
        switch type {
            case "PickUp":
                return TypeFeature.PickUp
                
            case "TakeBreak":
                return TypeFeature.TakeBreak
                
            case "HealthIndex":
                return TypeFeature.HealthIndex
                
            case "Message":
                return TypeFeature.Message
                
            case "MedicationAdvice":
                return TypeFeature.MedicationAdvice
                
            case "DayActivities":
                return TypeFeature.DayActivities
                
            case "News":
                return TypeFeature.News
                
            case "Tuition":
                return TypeFeature.Tuition
                
            case "Empty":
                return TypeFeature.Empty
            
            default:
                return TypeFeature.Empty
                
        }
    }
    
    static func convertDateYMDToDMY(date : String,separatorOut:String) -> String {
        let array = date.split(separator: "-")
        var dateConver = ""
        for item in array.reversed() {
            if dateConver == "" {
                dateConver = String(item)
            }else{
                dateConver = dateConver + separatorOut + item
            }
        }
        return dateConver
    }
    
    static func convertDateYYYYMMdd(date:Date) -> String {
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Convert Date to String
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }
    
    static func convertDateYYYYMMddToDDMMYYYY(dateString:String) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString) ?? Date()
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        let drawDate = formatDate.string(from: date)
        return drawDate
    }
    
    static func convertStringToDate(dateString:String) -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString) ?? Date()
        return date
    }
    
    func getNowDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let dateString = df.string(from: date)
        return dateString
    }
    
    static func SetAttribuedText(text:String, font:UIFont, strokeColor: UIColor, foregroundColor: UIColor, backgroundColor:UIColor  ) -> NSAttributedString{
        let Attributes = [
            NSAttributedString.Key.strokeColor : strokeColor,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.strokeWidth : 0.0,
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.backgroundColor : backgroundColor
            
            
            ] as [NSAttributedString.Key : Any]
        return NSAttributedString(string: text, attributes: Attributes)
    }
    
    static func gotoFeature(type: TypeFeature,root: UIViewController) {
        switch type {
        case .PickUp:
            HandlePush().pushToPickUpHome(root: root)
            break
        case .TakeBreak:
            HandlePush().pushLeaveLearn(root: root)
            break
        case .HealthIndex:
            HandlePush().pushIndexViewController(root: root)
            break
        case .Message:
            HandlePush().pushToHomeMessage(root: root)
            break
        case .MedicationAdvice:
            HandlePush().pushToMedicineHome(root: root)
            break
        case .DayActivities:
            HandlePush().pushActiveDayController(root: root)
            break
        case .News:
            HandlePush().pushNews(root: root)
            break
        case .Tuition:
            break
        case .Empty:
            break
        }
    }
    
    
    static func getHistoryPickUpByMonth(monthNext:Int, arrayHisstoryPickUpAll:[HistoryPickUpModel]) -> [HistoryPickUpModel] {
        let timestamp = Utilities.getCurrentTimestamp()
        let date = Double(timestamp).convertToDate().getPreviousOrNextMonth(value: monthNext)?.getDayMonthYearInt()
        
        var array: [HistoryPickUpModel] = []
        for item in arrayHisstoryPickUpAll {
            let dateItem = item.date.split(separator: "-")
            if dateItem.count == 3 {
                if Int(dateItem[0]) == date?.2 && Int(dateItem[1]) == date?.1 {
                    array.append(item)
                }
            }
        }
        return array
        
    }
    
   static func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
