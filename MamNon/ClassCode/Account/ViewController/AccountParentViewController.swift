//
//  AccountParentViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit
import SVProgressHUD

class AccountParentViewController: UIViewController {
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var viewLogout: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var labelEdit: UILabel!
    @IBOutlet weak var birthDayTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    var isEdit:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func setData() {
        
        if let obj = GlobalData.sharedInstance.userInfor?.user_info {
          
            if (obj.tel.count > 0) {
                self.phoneTF.text = obj.tel
            }else {
                self.phoneTF.placeholder = "Nhập số điện thoại của bạn"
            }
            
            if (obj.email.count > 0) {
                self.emailTF.text = obj.email
            }else {
                self.emailTF.placeholder = "Nhập email của bạn"
            }
            
            if (obj.parent_name.count > 0) {
                self.nameTF.text = obj.parent_name
            }else {
                self.nameTF.placeholder = "Nhập tên của bạn"
            }
            
            if (obj.address.count > 0) {
                self.addressTF.text = obj.address
            }else {
                self.addressTF.placeholder = "Nhập địa chỉ của bạn"
            }
            
            if (obj.birthday.count > 0) {
                self.birthDayTF.text = obj.birthday
            }else {
                self.birthDayTF.placeholder = "Nhập ngày sinh của bạn"
            }

        }
        self.endableTF()
        self.hidenControl()
    }
    
    func endableTF() {
        
        self.addressTF.isUserInteractionEnabled = self.isEdit
        self.nameTF.isUserInteractionEnabled = self.isEdit
        self.birthDayTF.isUserInteractionEnabled = self.isEdit
        self.phoneTF.isUserInteractionEnabled = self.isEdit
        self.emailTF.isUserInteractionEnabled = self.isEdit
        
    }
    
    func hidenControl() {
        self.viewPass.isHidden = self.isEdit
        self.editButton.isHidden = self.isEdit
        self.labelEdit.isHidden = self.isEdit
        self.viewLogout.isHidden = self.isEdit
        self.viewButton.isHidden = !self.isEdit
    }
    
    @IBAction func didSelectChangePass(_ sender: Any) {
        HandlePush().pushChangePasswordViewController(root: self)
    }
    @IBAction func didSelectEdit(_ sender: Any) {
        self.isEdit = !isEdit
        self.setData()
    }
    
    @IBAction func didSelectLogout(_ sender: Any) {
        HandlePush().goToLogin()
    }
    
    @IBAction func didSelectCancel(_ sender: Any) {
        self.isEdit = false
        self.setData()
    }
    @IBAction func didSelectUpdate(_ sender: Any) {
        
        self.updateData()
    }
    
    func updateData() {
        SVProgressHUD.show()
        AccounService().updateInforParent(self.nameTF.text ?? "", birthDay: self.birthDayTF.text ?? "", address: self.addressTF.text ?? "", email: self.emailTF.text ?? "", phone: self.phoneTF.text ?? "") { response in
            SVProgressHUD.dismiss()
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200{
                    self.isEdit = false
                    if let user_info  = responseModel.data {
                        let user = UserInforModel(JSON: user_info)
                        GlobalData.sharedInstance.userInfor = user
                        
                    }
                    self.setData()
                    self.view.makeToast("Thông tin đã được cập nhật!")
                }else {
                    self.view.makeToast("Lỗi cập nhật!")
                }
            }else {
                self.view.makeToast("Lỗi cập nhật!")
            }
            
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
}



