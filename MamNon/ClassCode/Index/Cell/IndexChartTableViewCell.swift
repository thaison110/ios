//
//  IndexChartTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit

class IndexChartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayHealth :[HealthModel] = []
    var heighMax : Float = 0
    var weightMax : Float = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "IndexChartItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IndexChartItemCollectionViewCell")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(array : [HealthModel]) {
        heighMax  = 0
        weightMax  = 0
        arrayHealth = array
        for item in array {
            if let height = item.height {
                if height > heighMax {
                    heighMax = height
                }
            }
            if let weight = item.weight {
                if weight > weightMax {
                    weightMax = weight
                }
            }
            
        }
        self.collectionView.reloadData()
    }
    
    
}

extension IndexChartTableViewCell :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayHealth.count
   
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndexChartItemCollectionViewCell", for: indexPath) as! IndexChartItemCollectionViewCell
        let obj = arrayHealth[indexPath.row]
        cell.cstHeightViewHeight.constant = CGFloat(155/heighMax*(obj.height ?? 0))
        cell.cstHeightViewWeight.constant = CGFloat(155/weightMax*(obj.weight ?? 0))
        cell.labelDay.text = Double(obj.date ?? 0).convertToShortDate()
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arrayHealth.count >= 6 {
            return CGSize(width: self.collectionView.frame.width/6, height: self.collectionView.frame.height)
        } else {
            return CGSize(width: self.collectionView.frame.width/CGFloat(arrayHealth.count), height: self.collectionView.frame.height)
        }
        
    }
}
