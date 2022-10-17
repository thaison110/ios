//
//  FeatureViewController.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 15/09/2022.
//

import UIKit

protocol FeatureViewControllerDelegate {
    func updateFeaturePin()
}

class FeatureViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    var arrayAll : [TypeFeature] = []
    
    var delegate : FeatureViewControllerDelegate?
    var isEdit  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "FeatureItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeatureItemCollectionViewCell")
        self.collectionView.register(UINib(nibName: "HeaderFeatureCollectionRsableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"HeaderFeatureCollectionRsableView")
        
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadArrayAll()
    }

    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else{
            return arrayAll.count
        }
   
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureItemCollectionViewCell", for: indexPath) as! FeatureItemCollectionViewCell
        if isEdit{
            cell.imageAddOrDelete.isHidden = false
        }else{
            cell.imageAddOrDelete.isHidden = true
        }
        
        if indexPath.section == 0 {
            if GlobalData.sharedInstance.arrayFeaturePin.count > indexPath.row{
                cell.getType(type: GlobalData.sharedInstance.arrayFeaturePin[indexPath.row])
            }else{
                cell.getType(type: TypeFeature.Empty)
            }
            cell.imageAddOrDelete.image = UIImage(named: "ic_DeleteItem")
        }else{
            cell.getType(type: arrayAll[indexPath.row])
            cell.imageAddOrDelete.image = UIImage(named: "ic_AddItem")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier:"HeaderFeatureCollectionRsableView", for: indexPath) as! HeaderFeatureCollectionRsableView
            if indexPath.section == 0{
                if isEdit {
                    headerView.buttonAcction.setTitle("Xong", for: .normal)
                    headerView.labelSubTitle.text = "Bấm nút (-) để loại tiện ích khỏi truy cập nhanh. Bấm nút (+) để thêm trở lại mục tiện ích nhanh."
                }else{
                    headerView.buttonAcction.setTitle("Chỉnh sửa", for: .normal)
                    headerView.labelSubTitle.text = "Những tiện ích này sẽ xuất hiện ở màn hình chính giúp bạn truy cập nhanh hơn."
                }
                headerView.labelTitle.text = "Tiện ích đã ghim"
                headerView.labelSubTitle.isHidden = false
                headerView.buttonAcction.isHidden = false
                headerView.delegate = self
            }else{
                headerView.labelTitle.text = "Tất cả tiện ích"
                headerView.labelSubTitle.isHidden = true
                headerView.buttonAcction.isHidden = true
            }
            return headerView
        }
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: SCREEN_WIDTH, height: 76)
        }
        else{
            return CGSize(width: SCREEN_WIDTH, height: 40)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEdit{
            if indexPath.section == 0 {
                if GlobalData.sharedInstance.arrayFeaturePin.count > indexPath.row{
                    GlobalData.sharedInstance.arrayFeaturePin.remove(at: indexPath.row)
                    loadArrayAll()
                    collectionView.reloadData()
                   
                }
                
            }else{
                if GlobalData.sharedInstance.arrayFeaturePin.count < 3{
                    GlobalData.sharedInstance.arrayFeaturePin.append(arrayAll[indexPath.row])
                    arrayAll.remove(at: indexPath.row)
                   
                    collectionView.reloadData()
                   
                }else{
                    self.showToast(message: "Danh sách truy cập nhanh đã đầy, bạn cần loại bớt để có thể thêm các tiện ích nhanh khác")
                }
                
            }
            
        }else{
            if indexPath.section == 0 {
                if GlobalData.sharedInstance.arrayFeaturePin.count > indexPath.row{
                    
                    Common.gotoFeature(type: GlobalData.sharedInstance.arrayFeaturePin[indexPath.row],root: self)
                }
                
            }else{
                Common.gotoFeature(type: arrayAll[indexPath.row],root: self)
            }
            
        }
    }
    
    
    
    func loadArrayAll(){
        var array : [TypeFeature] = []
        for item in Constants.arrayAllFeature{
            if GlobalData.sharedInstance.arrayFeaturePin.contains(where: {$0 == item}){
                
            }else{
                array.append(item)
            }
        }
        arrayAll = array
        self.collectionView.reloadData()
    }

}
extension FeatureViewController: HeaderFeatureCollectionRsableViewDelegate{
    func changeActionEidt() {
        if isEdit {
            isEdit = false
            if let delegate = self.delegate {
                delegate.updateFeaturePin()
                self.dismiss(animated: true)
                
            }
        }else{
            isEdit = true
        }
        Common.saveArrayFeatureToUserDefault(array: GlobalData.sharedInstance.arrayFeaturePin)
        collectionView.reloadData()
    }
}
