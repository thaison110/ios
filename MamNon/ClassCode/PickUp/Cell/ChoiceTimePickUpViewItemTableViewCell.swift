//
//  ChoiceTimePickUpViewItemTableViewCell.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 21/09/2022.
//

import UIKit

class ChoiceTimePickUpViewItemTableViewCell: UITableViewCell {
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var imageArrow: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var imageTime: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
