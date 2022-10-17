//
//  CreateMedicineNoteTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

protocol CreateMedicineNoteTableViewCellDelegate {
    func updateTextNote(note: String)
}

class CreateMedicineNoteTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var labelPlacehoder: UILabel!
    @IBOutlet weak var textViewNote: UITextView!
    var delegate :CreateMedicineNoteTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textViewNote.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.labelPlacehoder.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textViewNote.text.count == 0 {
            self.labelPlacehoder.isHidden = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateTextNote(note: textView.text)
        }
    }
}
