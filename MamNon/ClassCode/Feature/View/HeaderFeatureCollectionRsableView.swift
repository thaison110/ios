//
//  HeaderFeatureCollectionRsableView.swift
//  MamNon
//
//  Created by Ngo Thuy on 16/09/2022.
//

import UIKit
protocol HeaderFeatureCollectionRsableViewDelegate{
    func changeActionEidt()
}
class HeaderFeatureCollectionRsableView: UICollectionReusableView {

    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var buttonAcction: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    var delegate: HeaderFeatureCollectionRsableViewDelegate?
    
    override class func awakeFromNib() {
        
    }
   
    @IBAction func pressedAcction(_ sender: Any) {
        if let delegate = delegate {
            delegate.changeActionEidt()
        }
    }
}
