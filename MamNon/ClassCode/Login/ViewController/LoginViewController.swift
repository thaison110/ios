//
//  LoginViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 15/09/2022.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewPassWord: UIView!
    @IBOutlet weak var viewUserName: UIView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func pressedLogin(_ sender: Any) {
       
        SVProgressHUD.show()
        if textFieldPassword.text?.count ?? 0 > 0 && textFieldUserName.text?.count ?? 0 > 0 {
            let accountService = AccounService()
            accountService.loginUser(textFieldUserName.text ?? "", passWord: textFieldPassword.text ?? "") { response in
                if let responseModel = MetaResponse(JSON: response){
                    SVProgressHUD.dismiss()
                    if responseModel.status == 200{
                        if let token = responseModel.data?["token"] as? String{
                            GlobalData.sharedInstance.token = token
                            self.getInforAccount()
                        }
                        if let user_info  = responseModel.data?["user_info"] as? [String: Any]{
                            let user = UserModel(JSON: user_info)
                            GlobalData.sharedInstance.userLogin = user
                        }
                    }
                }
            } failure: { error in
                SVProgressHUD.dismiss()
            }
        }
        
        

        
    }
    
    func getInforAccount(){
        SVProgressHUD.show()
        let accountService = AccounService()
        accountService.getInforAccount { response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200{
//                    if let user_info  = responseModel.data?["user_info"] as? [String: Any]{
//                        let user = UserModel(JSON: user_info)
//                        GlobalData.sharedInstance.userInfor = user
//                        HandlePush().gotoTabBar()
//                    }
                    
                    if let user_info  = responseModel.data {
                        let user = UserInforModel(JSON: user_info)
                        GlobalData.sharedInstance.userInfor = user
                        HandlePush().gotoTabBar()
                    }
                }
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
    @IBAction func textFieldUserNamebeginEditing(_ sender: Any) {
        
        self.viewUserName.borderColor = UIColor(hexString: mainColor)
        
    }
    
    @IBAction func textFieldUserNameEndEditing(_ sender: Any) {

        self.viewUserName.borderColor = UIColor(hexString: "#E0E0E0")
    }
    
    @IBAction func textFieldPasswordbeginEditing(_ sender: Any) {
        self.viewPassWord.borderColor = UIColor(hexString: mainColor)
    }
    
    @IBAction func textFieldPasswordEndEditing(_ sender: Any) {
        self.viewPassWord.borderColor = UIColor(hexString: "#E0E0E0")
    }
}
