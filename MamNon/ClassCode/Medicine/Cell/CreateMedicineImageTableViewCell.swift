//
//  CreateMedicineImageTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class CreateMedicineImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cstWidthImage: NSLayoutConstraint!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
