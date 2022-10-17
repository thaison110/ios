//
//  MessageLeftItemTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 17/09/2022.
//

import UIKit

class MessageLeftItemTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var cstMaxWidthViewConten: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cstMaxWidthViewConten.constant = SCREEN_WIDTH - 125
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getData(obj: MessageChatModel){
        self.labelMessage.text = obj.detail
        self.labelTime.text = Double(obj.time).convertToDate().timeAgoDisplay()
    }
    
    
    
}
