//
//  ItemBoardHomeTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 17/09/2022.
//

import UIKit

class ItemBoardHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:ActivateModel?) {
        self.titleLabel.text = data?.title
        self.desLabel.text = data?.note
    }
    
}
