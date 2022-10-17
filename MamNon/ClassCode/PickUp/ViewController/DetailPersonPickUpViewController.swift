//
//  DetailPersonPickUpViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 22/09/2022.
//

import UIKit

protocol DetailPersonPickUpViewControllerDelete {
    func deletePersonPickUp(obj: ShuttlePersonModel)
    func updateArrayShuttlePerson(array:[ShuttlePersonModel])
}
class DetailPersonPickUpViewController: UIViewController {

    @IBOutlet weak var labelRelationship: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    var objShuttlePerson : ShuttlePersonModel?
    var arrayEditShuttlePerson : [ShuttlePersonModel]?
    var delegate :DetailPersonPickUpViewControllerDelete?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addViewHeader()
        self.setShadow()
        // Do any additional setup after loading the view.
        setData()
    }
    
    func setData(){
        if let obj = objShuttlePerson {
            imageAvatar.sd_setImage(with: URL(string: obj.image), placeholderImage: UIImage(named: "ic_CameraAvatar"))
            labelName.text = obj.name
            labelRelationship.text = arrayPersonPickUpDefaul[obj.relationship ?? 0]
        }
    }

    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
  
    @IBAction func pressedBack(_ sender: Any) {
        if let array = arrayEditShuttlePerson {
            if let delegate = delegate {
                delegate.updateArrayShuttlePerson(array: array)
            }
        }
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func pressedEidtPersonPickUp(_ sender: Any) {
        
        HandlePush().pushToCreateShuttlePerson(objEdit: objShuttlePerson, root: self)
    }
    @IBAction func pressedDelete(_ sender: Any) {
        if let id = objShuttlePerson?.id {
            deletePersonPickUp(id: id)
        }
    }
    
    func deletePersonPickUp(id: Int){
        SVProgressHUD.show()
        let service = PickUpService()
        service.deletePersonPickUp(id) { [self] response in
            SVProgressHUD.dismiss()
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200{
                    self.navigationController?.popViewController(animated: true)
                    if let delegate = self.delegate , let obj = self.objShuttlePerson {
                        delegate.deletePersonPickUp(obj: obj)
                    }
                }
                
            } else {
                
            }
        } failure: { error in
            SVProgressHUD.dismiss()
        }

       

    }
}

extension DetailPersonPickUpViewController : CreateShuttlePersonViewControllerDelegate {
    func updateListShuttlePerson(array: [ShuttlePersonModel]) {
        arrayEditShuttlePerson = array
        for item in array {
            if item.id == objShuttlePerson?.id {
                objShuttlePerson = item
                setData()
                break
            }
        }
    }
    
    
}
