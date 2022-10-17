//
//  CreateMedicineNameTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class CreateMedicineNameTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var textViewName: UITextView!
    @IBOutlet weak var labelPlacehoder: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textViewName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textViewDidChange(_ textView: UITextView) {
        if self.textViewName.text.count > 0 {
            self.labelPlacehoder.isHidden = true
        }else{
            self.labelPlacehoder.isHidden = false
        }
    }
}
