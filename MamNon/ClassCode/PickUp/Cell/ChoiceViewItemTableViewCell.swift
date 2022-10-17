//
//  ChoiceViewItemTableViewCell.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 21/09/2022.
//

import UIKit

class ChoiceViewItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageTick: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
