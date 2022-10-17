//
//  AccountParentTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class AccountParentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelBirthday: UILabel!
    @IBOutlet weak var labelName: UILabel!
    var root : UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(){
        if let obj = GlobalData.sharedInstance.userInfor?.user_info {
          
            self.labelPhone.text = obj.tel
            self.labelEmail.text = obj.email
            self.labelAddress.text = obj.address
            self.labelName.text = obj.parent_name
            self.labelBirthday.text = obj.birthday
        }
    }
    
    @IBAction func pressedChangePassWord(_ sender: Any) {
        if let root = root {
            HandlePush().pushChangePasswordViewController(root: root)
        }
    }
    @IBAction func pressedLogout(_ sender: Any) {
        HandlePush().goToLogin()
    }
}


