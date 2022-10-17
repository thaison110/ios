//
//  UtilitiHomeTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 15/09/2022.
//

import UIKit

class UtilitiHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collection: UICollectionView!
    var data:[TypeFeature] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.register(UINib (nibName: "FeatureItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeatureItemCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:[TypeFeature]) {
        self.data = data
        self.collection.reloadData()
    }
    
}

extension UtilitiHomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureItemCollectionViewCell", for: indexPath) as! FeatureItemCollectionViewCell
        cell.getType(type: self.data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: SCREEN_WIDTH/3 - 10, height: self.collection.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Common.gotoFeature(type: self.data[indexPath.row], root: UIApplication.getTopViewController() ?? UIViewController())
    }
    
}


