//
//  IndexChartItemCollectionViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit

class IndexChartItemCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var cstHeightViewWeight: NSLayoutConstraint!
    @IBOutlet weak var cstHeightViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewWeight: UIView!
    @IBOutlet weak var viewHeight: UIView!
    @IBOutlet weak var labelDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
