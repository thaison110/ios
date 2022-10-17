//
//  FeatureItemCollectionViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 16/09/2022.
//

import UIKit

class FeatureItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageAddOrDelete: UIImageView!
    @IBOutlet weak var imageFeature: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getType(type: TypeFeature){
        switch type {
            case .PickUp:
                imageFeature.image = UIImage(named: "ic_FeatureDonVe")
                labelName.text = "Đón về"
                break
            case .TakeBreak:
                imageFeature.image = UIImage(named: "ic_FeatureXinNghi")
                labelName.text = "Xin nghỉ"
                break
            case .HealthIndex:
                imageFeature.image = UIImage(named: "ic_FeatureChiSo")
                labelName.text = "Chỉ số"
                break
            case .Message:
                imageFeature.image = UIImage(named: "ic_FeatureLoiNhan")
                labelName.text = "Lời nhắn"
                break
            case .MedicationAdvice:
                imageFeature.image = UIImage(named: "ic_FeatureDanThuoc")
                labelName.text = "Dặn thuốc"
                break
            case .DayActivities:
                imageFeature.image = UIImage(named: "ic_FeatureHoatDongNgay")
                labelName.text = "Hoạt động ngày"
                break
            case .News:
                imageFeature.image = UIImage(named: "ic_FeatureTinTuc")
                labelName.text = "Tin tức"
                break
            case .Tuition:
                imageFeature.image = UIImage(named: "ic_FeatureHocPhi")
                labelName.text = "Học phí"
                break
            case .Empty:
                imageFeature.image = UIImage(named: "ic_FeatureEmty")
                labelName.text = ""
                imageAddOrDelete.isHidden = true
                break
        }
    }

}
