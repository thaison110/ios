//
//  AccountStudentTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class AccountStudentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelClass: UILabel!
    @IBOutlet weak var labelSchool: UILabel!
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var labelNickName: UILabel!
    @IBOutlet weak var labelBirthday: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    var actionEidtAccount = {  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func pressedEdit(_ sender: Any) {
        actionEidtAccount()
    }
    
    func setData(){
        if let obj = GlobalData.sharedInstance.userInfor?.user_info {
            self.imageAvatar.sd_setImage(with: URL(string: obj.avatar), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
            self.labelBirthday.text = obj.birthday
            self.labelNickName.text = obj.nickname
            self.labelName.text = obj.fullname
            if obj.gender == 0 {
                self.labelSex.text = "Nữ"
            }else{
                self.labelSex.text = "Nam"
            }
            self.labelSchool.text = "Trường Mầm Non Hoạ Mi"
            self.labelClass.text = obj.Class
        }
    }
    
}
