//
//  Constants.swift
//  tuetam
//
//  Created by iAm2r on 3/31/21.
//

import Foundation
import UIKit

let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
let SCREEN_SCALE         = UIScreen.main.bounds.size.width/375
let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate


// MARK: UIStoryboard
let shareInstanceMainStoryboard = UIStoryboard (name: "Main", bundle: nil)
let mainColor = "#FF7917"
let codeCheckSum = "908cbe89213798a473dae64a4dfa89ba"
let arrayPersonPickUpDefaul :[String] = ["Mẹ", "Bố","Ông", "Bà", "Cô", "Dì", "Chú", "Bác", "Anh", "Chị"]


struct Domain {
    static let BaseDomain = "https://kid.dzungnguyen.vn/"
    static let login = "\(Domain.BaseDomain)api-account/login"
    static let getInfo = "\(Domain.BaseDomain)api-account/get-info"
    static let getListTeacher = "\(Domain.BaseDomain)api-message/get-list-teacher"
    static let sendMessage = "\(Domain.BaseDomain)api-message/send"
    static let history = "\(Domain.BaseDomain)api-message/history"

    static let PickUpCreatePerson = "\(Domain.BaseDomain)api-homie/create"
    static let ListPickUpPerson = "\(Domain.BaseDomain)api-homie/get-list"
    static let SendPickup = "\(Domain.BaseDomain)api-homie/send-pickup"
    static let getListHistory = "\(Domain.BaseDomain)api-homie/get-list-history"
    static let DeletePersonPickUp = "\(Domain.BaseDomain)api-homie/delete-homie"
    static let EditPickup = "\(Domain.BaseDomain)api-homie/edit-homie"
    static let GetApiNews = "\(Domain.BaseDomain)api-news/get-list"
    static let GetApiDetailNews = "\(Domain.BaseDomain)api-news/detail"
    static let SendLeaveLearn = "\(Domain.BaseDomain)api-absence/send"
    static let GetHistoryLeaveLearn = "\(Domain.BaseDomain)api-absence/history"
    static let GetActiveDate = "\(Domain.BaseDomain)api-account/activate"

    
    static let GetListNotification = "\(Domain.BaseDomain)api-notify/get-list"
    static let GetHealth = "\(Domain.BaseDomain)api-account/health"
    static let MedicineSend = "\(Domain.BaseDomain)api-medicine/send"
    static let MedicineHistory = "\(Domain.BaseDomain)api-medicine/history"
    static let MedicineDelete = "\(Domain.BaseDomain)api-medicine/delete"
    static let ChangePassword = "\(Domain.BaseDomain)api-account/change-password"
    static let ChangeInfoStudent = "\(Domain.BaseDomain)api-account/change-info-student"
    static let ChangeInfoParent = "\(Domain.BaseDomain)api-account/change-info-parent"
}


struct Constants {
//    struct FontRaleway {
//        static let kFontBold13 = UIFont(name: "Raleway-Bold", size: 13)!
//        static let kFontRegular11 = UIFont(name: "Raleway-Regular", size: 11)!
//        static let kFontRegular12 = UIFont(name: "Raleway-Regular", size: 12)!
//        static let kFontRegular13 = UIFont(name: "Raleway-Regular", size: 13)!
//        static let kFontRegular14 = UIFont(name: "Raleway-Regular", size: 14)!
//        static let kFontMedium13 = UIFont(name: "Raleway-Medium", size: 13)!
//        static let kFontBold15 = UIFont(name: "Raleway-Bold", size: 15)!
//        static let kFontBold16 = UIFont(name: "Raleway-Bold", size: 16)!
//        static let kFontBold17 = UIFont(name: "Raleway-Bold", size: 17)!
//        static let kFontBold19 = UIFont(name: "Raleway-Bold", size: 19)!
//        static let kFontBold20 = UIFont(name: "Raleway-Bold", size: 20)!
//        static let kFontBold21 = UIFont(name: "Raleway-Bold", size: 21)!
//        static let kFontBold22 = UIFont(name: "Raleway-Bold", size: 22)!
//        static let kFontBold23 = UIFont(name: "Raleway-Bold", size: 23)!
//        static let kFontRegular15 = UIFont(name: "Raleway-Regular", size: 15)!
//        static let kFontRegular16 = UIFont(name: "Raleway-Regular", size: 16)!
//        static let kFontRegular17 = UIFont(name: "Raleway-Regular", size: 17)!
//        static let kFontRegular18 = UIFont(name: "Raleway-Regular", size: 18)!
//        static let kFontRegular19 = UIFont(name: "Raleway-Regular", size: 19)!
//        static let kFontRegular20 = UIFont(name: "Raleway-Regular", size: 20)!
//        static let kFontMedium15 = UIFont(name: "Raleway-Medium", size: 15)!
//        static let kFontMedium17 = UIFont(name: "Raleway-Medium", size: 17)!
//        static let kFontMedium18 = UIFont(name: "Raleway-Medium", size: 18)!
//        static let kFontMedium19 = UIFont(name: "Raleway-Medium", size: 19)!
//        static let kFontMedium22 = UIFont(name: "Raleway-Medium", size: 22)!
//        static let kFontMedium25 = UIFont(name: "Raleway-Medium", size: 25)!
//        static let kFontMedium35 = UIFont(name: "Raleway-Medium", size: 35)!
//
//        static let kFontSemibold32 = UIFont(name: "Raleway-Semibold", size: 32)!
//        static let kFontSemibold20 = UIFont(name: "Raleway-Semibold", size: 20)!
//        static let kFontSemibold17 = UIFont(name: "Raleway-Semibold", size: 17)!
//        static let kFontSemibold19 = UIFont(name: "Raleway-Semibold", size: 19)!
//        static let kFontSemibold15 = UIFont(name: "Raleway-Semibold", size: 15)!
//        static let kFontSemibold13 = UIFont(name: "Raleway-Semibold", size: 13)!
//    }
//
    
    static  var arrayAllFeature : [TypeFeature] = [TypeFeature.PickUp,TypeFeature.TakeBreak,TypeFeature.HealthIndex,TypeFeature.Message,TypeFeature.MedicationAdvice,TypeFeature.DayActivities,TypeFeature.News] //[TypeFeature.PickUp,TypeFeature.TakeBreak,TypeFeature.HealthIndex,TypeFeature.Message,TypeFeature.MedicationAdvice,TypeFeature.DayActivities,TypeFeature.News,TypeFeature.Tuition]
    
    struct FontName {
        
        static let kFontSFProRegular = "SFProDisplay-Regular"
        static let kFontSFProDisplayBlack = "SFProDisplay-Black"
        static let kFontSFProDisplayBlackItalic = "SFProDisplay-BlackItalic"
        static let kFontSFProDisplayBold = "SFProDisplay-Bold"
        static let kFontSFProDisplayHeavy = "SFProDisplay-Heavy"
        static let kFontSFProDisplayHeavyItalic = "SFProDisplay-HeavyItalic"
        static let kFontSFProDisplayLight = "SFProDisplay-Light"
        static let kFontSFProDisplayLightItalic = "SFProDisplay-LightItalic"
        static let kFontSFProDisplayMedium = "SFProDisplay-Medium"
        static let kFontSFProDisplayMediumItalic = "SFProDisplay-MediumItalic"
        static let kFontSFProDisplayRegularItalic = "SFProDisplay-RegularItalic"
        static let kFontSFProDisplaySemibold = "SFProDisplay-Semibold"
        static let kFontSFProDisplaySemiboldItalic = "SFProDisplay-SemiboldItalic"
        static let kFontSFProDisplayThin = "SFProDisplay-Thin"
        static let kFontSFProDisplayThinItalic = "SFProDisplay-ThinItalic"
        static let kFontSFProDisplayUltralight = "SFProDisplay-Ultralight"
        static let kFontSFProDisplayUltralightItalic = "SFProDisplay-UltralightItalic"
        static let kFontSFProDisplayItalic = "SFProDisplay-Italic"
        
        static let kFontIBMPlexSerifRegular = "IBMPlexSerif"
        static let kFontIBMPlexSerifSemiBold = "IBMPlexSerif-SemiBold"
    }
  


    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPHONE_TYPE_X      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0
    }
    
    struct ScreenSize{
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    
}
