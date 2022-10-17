//
//  ChangePasswordViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 05/10/2022.
//

import UIKit
protocol ChangePasswordViewControllerDelegate {
    func changePasswordSuccess()
}

class ChangePasswordViewController: UIViewController {
    var delegate : ChangePasswordViewControllerDelegate?
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewPassOld: UIView!
    @IBOutlet weak var viewPassNew: UIView!
    @IBOutlet weak var viewPassRetype: UIView!
    @IBOutlet weak var textFieldPassRetype: UITextField!
    
    @IBOutlet weak var textFieldPassOld: UITextField!
    @IBOutlet weak var textFieldPassNew: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addViewHeader()
    }


    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldPassOldbeginEditing(_ sender: Any) {
        
        self.viewPassOld.borderColor = UIColor(hexString: mainColor)
        
    }
    
    @IBAction func textFieldPassOldEndEditing(_ sender: Any) {

        self.viewPassOld.borderColor = UIColor(hexString: "#E0E0E0")
    }
    
    
    
    @IBAction func textFieldPassNewbeginEditing(_ sender: Any) {
        
        self.viewPassNew.borderColor = UIColor(hexString: mainColor)
        
    }
    
    @IBAction func textFieldPassNewEndEditing(_ sender: Any) {

        self.viewPassNew.borderColor = UIColor(hexString: "#E0E0E0")
    }
    
    
    @IBAction func textFieldPassRetypebeginEditing(_ sender: Any) {
        
        self.viewPassRetype.borderColor = UIColor(hexString: mainColor)
        
    }
    
    @IBAction func textFieldPassRetypeEndEditing(_ sender: Any) {

        self.viewPassRetype.borderColor = UIColor(hexString: "#E0E0E0")
    }
    @IBAction func pressedUpdate(_ sender: Any) {
        if textFieldPassOld.text?.count == 0 {
            self.showToast(message: "Bạn chưa nhập mật khẩu cũ")
        }else if textFieldPassNew.text?.count == 0 {
            self.showToast(message: "Bạn chưa nhập mật khẩu mới")
        }else if textFieldPassNew.text !=  textFieldPassRetype.text {
            self.showToast(message: "Mật khẩu xác nhận không đúng")
        }else {
            changePass()
        }
    }
    
    func changePass () {
        
        let service = AccounService()
        SVProgressHUD.show()
        service.changePassWord(textFieldPassOld.text ?? "", password_new: textFieldPassNew.text ?? "", password_new_retype: textFieldPassRetype.text ?? "") { response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200  {
                    
                    if let delegate = self.delegate {
                        delegate.changePasswordSuccess()
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
}
