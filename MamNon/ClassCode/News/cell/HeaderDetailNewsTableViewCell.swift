//
//  HeaderDetailNewsTableViewCell.swift
//  MamNon
//
//  Created by Truong Thang on 22/09/2022.
//

import UIKit

class HeaderDetailNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewIcon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewIcon.layer.cornerRadius = self.viewIcon.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(newsModel:NewsModel?) {
        
        self.titleLabel.text = newsModel?.name
        self.timeLabel.text = Double(newsModel?.time ?? 0).convertToDate().timeAgoDisplay()
        self.nameLabel.text = newsModel?.name
        
    }
    
}
