//
//  ChoiceImageViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 28/09/2022.
//

import UIKit
import Photos


protocol  ChoiceImageViewControllerDelegate {
   
    func pickListImage(listImage: [ImageLibraryModel])
    func close(listImage: [ImageLibraryModel]?)
}

class ChoiceImageViewController: UIViewController {
    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cstHeightCollectionView: NSLayoutConstraint!
    var delegate :ChoiceImageViewControllerDelegate?
    var arrayAlbum : [AlbumModel] = []
    var arrayImage : [ImageLibraryModel] = []
    var objAlbumChoice: AlbumModel?
    var choiceImageViewModel : ChoiceImageViewModel = ChoiceImageViewModel()
    var countImageChoiced = 0
    var  sizeCellImage:CGFloat = SCREEN_WIDTH/3 - 2
    var maxItem : Int = 40
    var arrayMediaChoiced : [ImageLibraryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "ChoiceImageItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChoiceImageItemCollectionViewCell")
        cstHeightCollectionView.constant = (SCREEN_WIDTH - 24)/2
        
        
        self.arrayAlbum = choiceImageViewModel.GetListAlbums()
        var objChoiceAlbum: AlbumModel?
        var countImageAlbum = 0
        for item in self.arrayAlbum{
            if(item.count == 0){
                continue
            }
            if(countImageAlbum > 0 && item.count > 1000){
                break
            }

            if(countImageAlbum == 0){
                countImageAlbum = item.count
                objChoiceAlbum = item
            }else if(countImageAlbum < item.count){
                countImageAlbum = item.count
                objChoiceAlbum = item
            }

        }
        
        if let _ = objChoiceAlbum?.collection {
            GetImage(album: (objChoiceAlbum?.collection)!)
        }
    }
    
    
    func GetImage(album: PHAssetCollection){
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotiRemoveVideoChoiceImage), object: nil)
        countImageChoiced = 0
        
        arrayImage = []
        arrayImage =  choiceImageViewModel.GetImageInAlbum(album: album)
        countImageChoiced = arrayMediaChoiced.count
        for item in arrayMediaChoiced {
            if let obj = arrayImage.first(where: {$0.asset == item.asset}) {
                obj.indexChoicedImage = item.indexChoicedImage
               
            }
        }
        collectionView.reloadData()

    }

    @IBAction func pressedClose(_ sender: Any) {
        if let delegate = delegate {
            delegate.close(listImage: nil)
        }
    }
    @IBAction func pressedDone(_ sender: Any) {
//        if arrayMediaChoiced.count > 0 {
            if let delegate = delegate {
                delegate.close(listImage: arrayMediaChoiced)
            }
//        }
        
        
    }
    
   
}

extension ChoiceImageViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayImage.count
      
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChoiceImageItemCollectionViewCell", for: indexPath) as! ChoiceImageItemCollectionViewCell
        let obj:ImageLibraryModel = arrayImage[indexPath.row]
        
        let imgManager=PHImageManager.default()
        let requestOptions=PHImageRequestOptions()
        requestOptions.isSynchronous=true
        requestOptions.deliveryMode = .highQualityFormat
        let objImage :ImageLibraryModel = ImageLibraryModel()
        objImage.indexChoicedImage = obj.indexChoicedImage
        objImage.asset  = obj.asset
        if(obj.asset!.mediaType.rawValue == PHAssetMediaType.image.rawValue){ // nếu là ảnh
//            imgManager.requestImage(for: obj.asset!, targetSize: PHImageManagerMaximumSize,contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
            imgManager.requestImage(for: obj.asset!, targetSize: CGSize(width:sizeCellImage, height: sizeCellImage),contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, error) in
                //                        self.imageArray.append(image!)
                objImage.setData(image: image!, type: "Image", duration: "")
                
                
                
            })
        }else{
            
            imgManager.requestImage(for: obj.asset!, targetSize: CGSize(width:sizeCellImage, height: sizeCellImage),contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, error) in

                objImage.setData(image: image!, type: "Video", duration: String(format: "%02d:%02d",Int((obj.asset!.duration / 60)),Int(obj.asset!.duration) % 60))

                
                
            })
            
           
        }
        
        cell.SetData(objIamge: objImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:( SCREEN_WIDTH - 24)/4, height: ( SCREEN_WIDTH - 24)/4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj  : ImageLibraryModel = arrayImage[indexPath.row]
        let boolValue = obj.checkSize()
//        print("value \(boolValue) || \(boolValue ? "true" : "false")")
        if !boolValue{
            self.showAlertSize()
            return;
        }
        if countImageChoiced >= maxItem && maxItem != 0 && obj.indexChoicedImage == 0 {
            return
        }
        
        if(obj.indexChoicedImage == 0 ){
            obj.indexChoicedImage = countImageChoiced + 1
            countImageChoiced = countImageChoiced + 1
            
            arrayMediaChoiced.append(obj)
        }else{
//            var countImage = 0
//            for i in 0..<arrayImage.count {
//                let objImage = arrayImage[i]
//                if(objImage.indexChoicedImage > 0){
//                    countImage = countImage + 1
//                }
//                if(objImage.indexChoicedImage > obj.indexChoicedImage){
//                    objImage.indexChoicedImage = objImage.indexChoicedImage - 1
//                }
//
//                if(countImage == countImageChoiced ){
//                    break
//                }
//
//            }
            for i in 0..<arrayMediaChoiced.count {
                
                let objImage = arrayMediaChoiced[i]
                if(objImage.indexChoicedImage > obj.indexChoicedImage){
                    objImage.indexChoicedImage = objImage.indexChoicedImage - 1
                }
                
            }
            
            for i in 0..<arrayMediaChoiced.count {
                
                let objImage = arrayMediaChoiced[i]
               
                if (objImage.asset?.localIdentifier == obj.asset?.localIdentifier){
                    arrayMediaChoiced.remove(at: i)
                    break
                }
            }
            obj.indexChoicedImage = 0
            countImageChoiced = countImageChoiced - 1
        }
        
        
//        if(obj.asset?.mediaType.rawValue == PHAssetMediaType.video.rawValue && obj.indexChoicedImage > 0){
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotiPauseVideoChoiceImage), object: "")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotiRemoveVideoChoiceImage), object: "")
//
//                let cell = collectionView.cellForItem(at: indexPath) as! ChoiceImageCollectionViewCell
//                cell.PlayVideo()
//
//            }
//        }
        
       
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            
            for i in 0..<self.arrayImage.count {
                
                let objImage:ImageLibraryModel = self.arrayImage[i]
                if(objImage.isCheckCellActive){
                    let indexPathImage = IndexPath(item: i, section: 0)
                    let cell = collectionView.cellForItem(at: indexPathImage) as! ChoiceImageItemCollectionViewCell
                    if(objImage.indexChoicedImage  > 0){
                        cell.viewNumber.isHidden = false
                        cell.labelNumber.text = "\(objImage.indexChoicedImage)"
                    }else{
                        cell.viewNumber.isHidden = true
                    }
                }
                
            }
        }
        
        if arrayMediaChoiced.count > 0 {
            labelNext.text = "Tiếp tục (\(arrayMediaChoiced.count))"
        }else {
            labelNext.text = "Tiếp tục"
        }
        
    }
    
    
    func showAlertSize(){
        let alert = UIAlertController(title: nil, message: "Vui lòng chọn video không quá \(300)MB và image không quá \(15)MB", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true) {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath)
        if(arrayImage.count > indexPath.row){
            let obj = self.arrayImage[indexPath.row]
            obj.isCheckCellActive = false
            if(obj.asset?.mediaType.rawValue == PHAssetMediaType.video.rawValue){


            }
        }

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath)
        if(arrayImage.count > indexPath.row){
            let obj = arrayImage[indexPath.row]
            obj.isCheckCellActive = true
        }

    }
}

