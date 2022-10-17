//
//  DetailImageTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 25/09/2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
