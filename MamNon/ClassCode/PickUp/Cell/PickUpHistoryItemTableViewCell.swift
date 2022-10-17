//
//  PickUpHistoryItemTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit

class PickUpHistoryItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataCellCreatePickUp(obj:HistoryPickUpModel) {
        labelTime.text = Common.convertDateYMDToDMY(date: obj.date, separatorOut: "/")
        let arrayAttribuedTitle = NSMutableAttributedString()
        var arrtributedTitle : NSAttributedString = NSAttributedString.init()
        
        arrtributedTitle = Common.SetAttribuedText(text: obj.relationship + "   ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#005CC8"), backgroundColor: UIColor.clear)
        arrayAttribuedTitle.append(arrtributedTitle)
        var type = "Đón đúng giờ"
        if obj.type == 1 {
            type = "Đón sớm"
        }else if obj.type == 2 {
            type = "Đón muộn"
        }
       
        arrtributedTitle = Common.SetAttribuedText(text: type + "   ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#FF7917"), backgroundColor: UIColor.clear)
        
        arrayAttribuedTitle.append(arrtributedTitle)
        let dateCreate = Double(obj.created_at ?? 0)
        let textTimeCreate = "   Đã tạo lúc " + dateCreate.convertToTime() + ", " + dateCreate.convertToDateWidgetDDMMYY()
        arrtributedTitle = Common.SetAttribuedText(text: textTimeCreate, font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#828282"), backgroundColor: UIColor.clear)

        arrayAttribuedTitle.append(arrtributedTitle)
      
        labelSubtitle.attributedText = arrayAttribuedTitle
        
       
    }
    
    func setDataHistoryCreatePickUp(obj:HistoryPickUpModel) {
        labelTime.text = Common.convertDateYMDToDMY(date: obj.date, separatorOut: "/")
        let arrayAttribuedTitle = NSMutableAttributedString()
        var arrtributedTitle : NSAttributedString = NSAttributedString.init()
        
        arrtributedTitle = Common.SetAttribuedText(text: obj.relationship + "   ", font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#005CC8"), backgroundColor: UIColor.clear)
        arrayAttribuedTitle.append(arrtributedTitle)
     
        
       
     
        let textTimeCreate = "   Đón bé lúc " + obj.hour
        arrtributedTitle = Common.SetAttribuedText(text: textTimeCreate, font:UIFont(name:Constants.FontName.kFontSFProRegular , size: 13)!  , strokeColor: UIColor.black, foregroundColor: UIColor.init(hexString: "#828282"), backgroundColor: UIColor.clear)

        arrayAttribuedTitle.append(arrtributedTitle)
      
        labelSubtitle.attributedText = arrayAttribuedTitle
        
       
    }
    
}
