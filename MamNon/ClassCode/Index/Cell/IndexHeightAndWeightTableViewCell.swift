//
//  IndexHeightAndWeightTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit

class IndexHeightAndWeightTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTimeWeight: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelTimeHeight: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(obj: HealthModel){
        self.labelWeight.text = "\(obj.weight ?? 0)"
        self.labelHeight.text = "\( obj.height ?? 0)"
        let time = Double(obj.date ?? 0).convertToTimeDayMonthYear()
        self.labelTimeHeight.text = time
        self.labelTimeWeight.text = time
    }
    
}
