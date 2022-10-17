//
//  MedicineHomeItemTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class MedicineHomeItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNumberMedicine: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var buttonClick: UIButton!
    @IBOutlet weak var labeltime: UILabel!
    @IBOutlet weak var imageMedicine: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(obj: MedicineModel) {
        if obj.image.count > 0 {
            imageMedicine.sd_setImage(with: URL(string: obj.image[0]), placeholderImage: UIImage(named: "ic_Medicine"))
            labelNumberMedicine.text = "\(obj.image.count) loại"
        }else {
            imageMedicine.image = UIImage(named: "ic_Medicine")
            labelNumberMedicine.text = ""
        }
        
        
        if let timeStart = Double(obj.date_start ?? 0).convertToDate().getDayMonthYearInt() , let timeEnd = Double(obj.date_end ?? 0).convertToDate().getDayMonthYearInt(){
//            let timeNow = Double(Utilities.getCurrentTimestamp()).convertToDate()
//            let numberDay = Double(obj.date_end ?? 0).convertToDate().days(from: timeNow)
//            if numberDay > 0 {
//                labeltime.text = "\(timeStart.0) thg \(timeStart.1) - \(timeEnd.0) thg \(timeEnd.1) (Còn \(numberDay) ngày)"
//            }else {
//                labeltime.text = "\(timeStart.0) thg \(timeStart.1) - \(timeEnd.0) thg \(timeEnd.1)"
//            }
            labelName.text = "\(timeStart.0)/\(timeStart.1)/\(timeStart.2)"
        }
        
        
        labelNote.text = obj.note
        
        if let teacher_confirm = obj.teacher_confirm {
            let arrayAttribuedTitle = NSMutableAttributedString()
            var arrtributedTitle : NSAttributedString = NSAttributedString.init()
            
            arrtributedTitle = Common.SetAttribuedText(text: "Đã xác nhận ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#005CC8"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            
            arrtributedTitle = Common.SetAttribuedText(text: "bởi ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#828282"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            
            arrtributedTitle = Common.SetAttribuedText(text: teacher_confirm, font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.black, backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            self.labeltime.attributedText = arrayAttribuedTitle
        }else {
            let arrayAttribuedTitle = NSMutableAttributedString()
            var arrtributedTitle : NSAttributedString = NSAttributedString.init()
            
            arrtributedTitle = Common.SetAttribuedText(text: "Chưa xác nhận", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#FF5959"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            self.labeltime.attributedText = arrayAttribuedTitle
        }
        
        
        
        
    }
    
}
