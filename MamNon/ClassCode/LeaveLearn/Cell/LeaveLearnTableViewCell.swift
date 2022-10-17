//
//  LeaveLearnTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 18/09/2022.
//

import UIKit

class LeaveLearnTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    var data:LeaveModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:LeaveModel?) {
        self.data = data
        dateLabel.text = Common.convertDateYYYYMMddToDDMMYYYY(dateString: data?.dates ?? "")
        typeLabel.text = "Nghỉ có phép"
        checkLabel.text = data?.statusString
        
        
    }
    
}
