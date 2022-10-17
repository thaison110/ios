//
//  CreateShuttlePersonViewController.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 20/09/2022.
//

import UIKit
import Photos
import MobileCoreServices
import AVKit

protocol CreateShuttlePersonViewControllerDelegate{
    func updateListShuttlePerson(array:[ShuttlePersonModel])
}

class CreateShuttlePersonViewController: UIViewController {
   
    
    @IBOutlet weak var textFeildName: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var labelPerson: UILabel!
    let pickerView = UIPickerView()
    var delegate: CreateShuttlePersonViewControllerDelegate?
    var indexChoicePersion = 0
    var imageAvatarChoice : UIImage?
    var isCheckCallApi = false
    var objEditPersonPickUp :ShuttlePersonModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        setShadow()
        // Do any additional setup after loading the view.
            
        setDataEdit()
        
    }
    
    func setDataEdit() {
        if let obj = objEditPersonPickUp {
            imageAvatar.sd_setImage(with: URL(string: obj.image), placeholderImage:  UIImage(named: "ic_AvatarDefaul"))
            labelPerson.text = arrayPersonPickUpDefaul[obj.relationship ?? 0]
            textFeildName.text = obj.name
            indexChoicePersion = obj.relationship ?? 0
        }
    }

    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func setShadow(){
        // corner radius
        viewContent.layer.cornerRadius = 12

        // border
        viewContent.layer.borderWidth = 1.0
        viewContent.layer.borderColor = UIColor.white.cgColor

        // shadow
        viewContent.layer.shadowColor = UIColor.lightGray.cgColor
        viewContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewContent.layer.shadowOpacity = 0.6
        viewContent.layer.shadowRadius = 4.0
       
    }
    
    @IBAction func pressedShowImage(_ sender: Any) {
        showCameraDefault(fromSourceType: .photoLibrary)
    }
    @IBAction func pessedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressedChoicePerson(_ sender: Any) {
       HandlePresent().showPickerViewChoiceViewController(indexChoice: indexChoicePersion, arrayChoice: arrayPersonPickUpDefaul, root: self)
       
    }
    
    
    func showCameraDefault(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.mediaTypes = [kUTTypeImage as String]
            picker.mediaTypes.append(kUTTypeMovie as String)
            picker.allowsEditing = false
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func pressedSavePerson(_ sender: Any) {
        if textFeildName.text?.count ?? 0 > 0 {
            var imageBase64 = ""
            if let image = imageAvatarChoice{
                if let imageResize = Common.resizeImage(image: image, targetSize: CGSize(width: 200, height: 200)){
                    imageBase64 = "data:image/png;base64," + Common.convertImageToBase64String(img:imageResize)
                }
               
            }
            if objEditPersonPickUp != nil {
                if imageBase64.count > 0 {
                    self.editPersonPickUp(image: imageBase64)
                } else {
                    self.editPersonPickUp(image: nil)
                }
               
            } else {
                self.savePerson(image: imageBase64)
            }
            
            
        }else{
            self.showToast(message: "Bạn chưa nhập tên người đón")
        }
    }
    
    func savePerson(image: String){
        if isCheckCallApi {
            return
        }
        SVProgressHUD.show()
        isCheckCallApi = true
        let pickUpService = PickUpService()
        
        pickUpService.addPersonPickUp(textFeildName.text ?? "", image: image, relationship: indexChoicePersion) { response in
            self.isCheckCallApi = false
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200{
                    
                    if let data = response["data"] as? [[String : Any]]{
                        var array: [ShuttlePersonModel] = []
                        for item in data {
                            if let obj = ShuttlePersonModel(JSON: item) {
                                array.append(obj)
                            }
                            
                        }
                        if let delegate = self.delegate {
                            delegate.updateListShuttlePerson(array: array)
                            self.navigationController?.popViewController(animated: true)
                        }
                      
                    }
                }
               
              
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            self.isCheckCallApi = false
            print(error)
            SVProgressHUD.dismiss()
        }

    }
    
    func editPersonPickUp(image: String?){
        if isCheckCallApi {
            return
        }
        SVProgressHUD.show()
        isCheckCallApi = true
        let pickUpService = PickUpService()
        pickUpService.editPersonPickUp(textFeildName.text ?? "", image: image, relationship: indexChoicePersion, id: objEditPersonPickUp?.id ?? 0) { response in
            self.isCheckCallApi = false
            if let responseModel = MetaResponse(JSON: response) {
                if responseModel.status == 200 {
                    
                    if let data = response["data"] as? [[String : Any]]{
                        var array: [ShuttlePersonModel] = []
                        for item in data {
                            if let obj = ShuttlePersonModel(JSON: item) {
                                array.append(obj)
                            }
                            
                        }
                        if let delegate = self.delegate {
                            delegate.updateListShuttlePerson(array: array)
                            self.navigationController?.popViewController(animated: true)
                        }
                      
                    }
                }
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            self.isCheckCallApi = false
            SVProgressHUD.dismiss()
        }

    }
}
extension CreateShuttlePersonViewController : PickerViewChoiceViewControllerDelegate {
    func choiceItem(index: Int, text: String) {
        indexChoicePersion = index
        labelPerson.text = text
    }
}



extension CreateShuttlePersonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageAvatar.image = image
        imageAvatarChoice = image

        
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
        
    }
    
    
}
