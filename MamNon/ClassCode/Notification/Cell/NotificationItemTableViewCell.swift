//
//  NotificationItemTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit

class NotificationItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setdata(obj: NotificationModel) {
        labelTitle.text = obj.sender_name
        labelSubtitle.text = obj.title
        if let time = obj.created_at {
            labelTime.text = Double(time).convertToDate().timeAgoDisplay()
        }else {
            labelTime.text = ""
        }
        
    }
}
