//
//  MedicineDetailHeaderTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 01/10/2022.
//

import UIKit

class MedicineDetailHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageMedicine: UIImageView!
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
        }else {
            imageMedicine.image = UIImage(named: "ic_Medicine")
        }
        if  let time = Double(obj.date_start ?? 0).convertToDate().getDayMonthYearInt() {
            labelDate.text = "\(time.0)/\(time.1)/\(time.2)"
        }else {
            labelDate.text = ""
        }
        
        if  let time = obj.created_at,  let day = Double(time).convertToDate().getDayMonthYearInt() , let hour =  Double(time).convertToDate().getTimeHHMMSS() {
            
            labelSubTitle.text =   "Đã tạo vào lúc \(hour.0):\(hour.1), ngày \(day.0) Tháng \(day.1), \(day.2)"
        }else {
            labelSubTitle.text = ""
        }
        
        if let teacher_confirm = obj.teacher_confirm {
            let arrayAttribuedTitle = NSMutableAttributedString()
            var arrtributedTitle : NSAttributedString = NSAttributedString.init()
            
            arrtributedTitle = Common.SetAttribuedText(text: "Đã xác nhận ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#005CC8"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            
            arrtributedTitle = Common.SetAttribuedText(text: "bởi ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#828282"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            
            arrtributedTitle = Common.SetAttribuedText(text: teacher_confirm, font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.black, backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            self.labelSubTitle.attributedText = arrayAttribuedTitle
        }else {
            let arrayAttribuedTitle = NSMutableAttributedString()
            var arrtributedTitle : NSAttributedString = NSAttributedString.init()
            
            arrtributedTitle = Common.SetAttribuedText(text: "Chưa xác nhận", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#FF5959"), backgroundColor: UIColor.clear)
            arrayAttribuedTitle.append(arrtributedTitle)
            self.labelSubTitle.attributedText = arrayAttribuedTitle
        }
    }
}
