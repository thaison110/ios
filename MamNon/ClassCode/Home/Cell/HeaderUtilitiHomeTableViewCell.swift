//
//  HeaderUtilitiHomeTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 16/09/2022.
//

import UIKit

class HeaderUtilitiHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    var seeMore:((_ data:HomeModel?)-> Void)?
    var data:HomeModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:HomeModel?) {
        self.data = data
        self.titleLabel.text = data?.titleHeader
        self.seeMoreButton.setTitle(data?.titleButton, for: .normal)
        self.seeMoreButton.isHidden = false
        if (data?.typeHome ?? .Activate) == .Activate {
            self.seeMoreButton.isHidden = true
        }
    }
    
    @IBAction func didSelectMore(_ sender: Any) {
        self.seeMore?(self.data)
    }
    
}
