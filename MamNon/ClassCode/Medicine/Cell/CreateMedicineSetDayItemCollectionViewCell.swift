//
//  CreateMedicineSetDayItemCollectionViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class CreateMedicineSetDayItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var viewContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.backgroundColor = UIColor(hexString: "#F2F2F2")
        
        self.contentView.clipsToBounds = true
      
    }

}
