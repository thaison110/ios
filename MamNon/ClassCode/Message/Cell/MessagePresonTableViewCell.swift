//
//  MessagePresonTableViewCell.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 16/09/2022.
//

import UIKit

class MessagePresonTableViewCell: UITableViewCell {

    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewBaged: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getData(obj : ChatPersonModel){
        labelName.text = obj.name
        labelMessage.text = obj.text_last
        imageAvatar.sd_setImage(with: URL(string: obj.avatar), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
    }
}
