//
//  ChoiceImageItemCollectionViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 28/09/2022.
//

import UIKit

class ChoiceImageItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func SetData(objIamge:ImageLibraryModel)  {
        image.image = objIamge.image
//        if(objIamge.type == "Video"){
//            labelDuration.text = objIamge.duration
//            self.viewVideo.isHidden = false
//        }else{
//            labelDuration.text = ""
//            self.viewVideo.isHidden = true
//        }
//        
        if(objIamge.indexChoicedImage  > 0){
            viewNumber.isHidden = false
            labelNumber.text = "\(objIamge.indexChoicedImage)"
        }else{
            viewNumber.isHidden = true
        }
//        self.objImage = objIamge
    }

}
