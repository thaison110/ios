//
//  ShuttlePersonItemTableViewCell.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 20/09/2022.
//

import UIKit

class ShuttlePersonItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRelationship: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(obj: ShuttlePersonModel){
        imageAvatar.sd_setImage(with: URL(string: obj.image), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
        labelName.text = obj.name
        labelRelationship.text = arrayPersonPickUpDefaul[obj.relationship ?? 0]
    }
}
