//
//  Enums.swift
//  tuetam
//
//  Created by Dinh Dai on 4/5/21.
//

import UIKit

//["PickUp","TakeBreak","HealthIndex","Message","MedicationAdvice","DayActivities","News","Tuition"]
enum TypeFeature: String{
    case PickUp = "PickUp" // đón về
    case TakeBreak = "TakeBreak" // xin nghỉ
    case HealthIndex = "HealthIndex" // chỉ số
    case Message = "Message" //lời nhắn
    case MedicationAdvice = "MedicationAdvice" // dặn thuốc
    case DayActivities = "DayActivities" // hoạt động ngày
    case News = "News" // tin tức
    case Tuition = "Tuition" // học phí
    case Empty = "Empty" // học phí
}


enum TypeHome{
    case Activate
    case News
    case Utiliti
}


