//
//  NewsTableViewCell.swift
//  MamNon
//
//  Created by Truong Thang on 15/09/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var iconSpecicalImahe: UIImageView!
    @IBOutlet weak var specicalLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.iconView.layer.cornerRadius = self.iconView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(news:NewsModel?) {
        self.titleLabel.text = news?.name
        self.nameLabel.text = news?.created_by
        self.avatarImage.sd_setImage(with: URL (string: news?.image ?? ""))
        self.timeLabel.text = Double(news?.time ?? 0).convertToDate().timeAgoDisplay()
    }
    
}
