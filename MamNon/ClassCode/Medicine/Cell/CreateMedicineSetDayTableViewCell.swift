//
//  CreateMedicineSetDayTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class CreateMedicineSetDayTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchRepeat: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CreateMedicineSetDayItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreateMedicineSetDayItemCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 49

        let heightRatio = 24 / standardHeight
        let widthRatio = 42 / standardWidth

               
        self.switchRepeat.transform =  CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
    
}
extension CreateMedicineSetDayTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
      
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateMedicineSetDayItemCollectionViewCell", for: indexPath) as! CreateMedicineSetDayItemCollectionViewCell
        cell.viewContent.cornerRadius = (( SCREEN_WIDTH - 64)/7 - 8)/2
        if indexPath.row == 0 {
            cell.labelDay.text = "T2"
        }else if indexPath.row == 1 {
            cell.labelDay.text = "T3"
        }else if indexPath.row == 2 {
            cell.labelDay.text = "T4"
        }else if indexPath.row == 3 {
            cell.labelDay.text = "T5"
        }else if indexPath.row == 5 {
            cell.labelDay.text = "T6"
        }else if indexPath.row == 6 {
            cell.labelDay.text = "T7"
        }else if indexPath.row == 7 {
            cell.labelDay.text = "CN"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:( SCREEN_WIDTH - 64)/7, height: ( SCREEN_WIDTH - 64)/7)
    }
}
