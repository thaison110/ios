//
//  CreateMedicineListImageTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 28/09/2022.
//

import UIKit

class CreateMedicineListImageTableViewCell: UITableViewCell {

    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cstHeightViewContent: NSLayoutConstraint!
    @IBOutlet weak var viewContent: UIView!
    var arrayImage: [ImageLibraryModel] = []
    var objMedicine : MedicineModel?
    var isCheckDetail = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CreateMedicineImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreateMedicineImageCollectionViewCell")
       
        
    }
    
    func setData (array : [ImageLibraryModel]) {
        self.arrayImage = array
        collectionView.register(UINib(nibName: "CreateMedicineImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreateMedicineImageCollectionViewCell")
        page.numberOfPages = arrayImage.count
        collectionView.reloadData()
        
    }
    
    func setDataDetail (obj : MedicineModel) {
        isCheckDetail = true
        self.objMedicine = obj
        collectionView.register(UINib(nibName: "CreateMedicineImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CreateMedicineImageCollectionViewCell")
        page.numberOfPages = obj.image.count
        collectionView.reloadData()
        
    }

    @IBAction func changeValuePage(_ sender: Any) {
        self.scrollToIndex(index: page.currentPage)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension CreateMedicineListImageTableViewCell :  UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isCheckDetail {
            if let obj = objMedicine {
                return obj.image.count
            }
            return 0
        }else {
            return arrayImage.count
        }
        
      
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateMedicineImageCollectionViewCell", for: indexPath) as! CreateMedicineImageCollectionViewCell
        
       
        if isCheckDetail {
            if let obj = objMedicine {
                cell.image.sd_setImage(with: URL(string: obj.image[indexPath.row]), placeholderImage: UIImage(named: ""))
            }
            
        }else {
            let obj = arrayImage[indexPath.row]
            cell.image.image = obj.image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:( SCREEN_WIDTH - 24), height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathsForVisibleItems.first {
            page.currentPage = indexPath.row
        }
    }
    
    func scrollToIndex(index:Int) {
           let rect = self.collectionView.layoutAttributesForItem(at: IndexPath(row: index, section: 0))?.frame
           self.collectionView.scrollRectToVisible(rect!, animated: true)
    }
}
