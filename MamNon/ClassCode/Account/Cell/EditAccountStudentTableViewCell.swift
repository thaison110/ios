//
//  EditAccountStudentTableViewCell.swift
//  MamNon
//
//  Created by Ngo Thuy on 06/10/2022.
//

import UIKit
protocol EditAccountStudentTableViewCellDelegate {
    
}

class EditAccountStudentTableViewCell: UITableViewCell {
    @IBOutlet weak var labelClass: UILabel!
    @IBOutlet weak var labelSchool: UILabel!
    @IBOutlet weak var labelSex: UILabel!
  
   
    @IBOutlet weak var textFieldBirthday: UITextField!
    
    @IBOutlet weak var textFileldNickName: UITextField!
    @IBOutlet weak var textFiledName: UITextField!
    @IBOutlet weak var imageAvatar: UIImageView!
    var root: UIViewController?
    var imageAvatarUpdate : UIImage?
    var sex: Int = 0
    var datePicker :UIDatePicker!
    var dateBirthday : Date?
    var viewChoiceSex: ChoiceItemView?
    var updateAccountSuccess = {(isSuccess : Bool) in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setData()
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 500))
        textFieldBirthday.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        textFieldBirthday.inputView = datePicker
               let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
               let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        textFieldBirthday.inputAccessoryView = toolBar
    }

    @objc func datePickerDone() {
          
        textFieldBirthday.resignFirstResponder()
      }

      @objc func dateChanged() {
          if  let time = datePicker.date.getDayMonthYearInt() {
              dateBirthday = datePicker.date
              textFieldBirthday.text = "\(time.2)-\(time.1)-\(time.0)"
          }
          
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpdateImage(image : UIImage) {
        self.imageAvatarUpdate = image
        imageAvatar.image = image
    }
    
    func setData(){
        if let obj = GlobalData.sharedInstance.userInfor?.user_info {
            sex = obj.gender ?? 0
            self.imageAvatar.sd_setImage(with: URL(string: obj.avatar), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
            self.textFieldBirthday.text = obj.birthday
            self.textFileldNickName.text = obj.nickname
            self.textFiledName.text = obj.fullname
            if obj.gender == 0 {
                
                self.labelSex.text = "Nữ"
            }else{
                self.labelSex.text = "Nam"
            }
            self.labelSchool.text = "Trường Mầm Non Hoạ Mi"
            self.labelClass.text = obj.Class
        }
    }
    
    @IBAction func pressedChageImageAvatar(_ sender: Any) {
        if let root = root {
            HandlePresent().showChoiceImageViewController(maxItem: 1 ,root: root)
        }
        
    }
    

    @IBAction func changeSex(_ sender: Any) {
        if sex == 0 {
            self.addViewChoiceSex(array: ["Nữ","Nam"], indexChoice: 0)
        }else {
            self.addViewChoiceSex(array: ["Nữ","Nam"], indexChoice: 1)
        }
       
    }

    
    @IBAction func pressedCancel(_ sender: Any) {
        self.updateAccountSuccess(false)
    }
    @IBAction func pressedUpdate(_ sender: Any) {
        let service = AccounService()
        var avatar : String =  ""
        if let image = imageAvatarUpdate {
            avatar = "data:image/png;base64," + Common.convertImageToBase64String(img:image)
        }
        
        service.updateInforStudent(textFiledName.text ?? "", nickname: textFileldNickName.text ?? "", image: avatar, birthday: textFieldBirthday.text ?? "", gender: sex) { response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200 {
                    if let data = response["data"] as? [String : Any] {
                        if let user_info = data["user_info"] as? [String : Any] {
                            if let fullname = user_info["fullname"] as? String {
                                GlobalData.sharedInstance.userInfor?.user_info?.fullname = fullname
                            }
                            if let avatar = user_info["avatar"] as? String {
                                GlobalData.sharedInstance.userInfor?.user_info?.avatar = avatar
                            }
                            if let nickname = user_info["nickname"] as? String {
                                GlobalData.sharedInstance.userInfor?.user_info?.nickname = nickname
                            }
                            if let birthday = user_info["birthday"] as? String {
                                GlobalData.sharedInstance.userInfor?.user_info?.birthday = birthday
                            }
                            if let gender = user_info["gender"] as? String {
                                if gender == "Nữ" {
                                    GlobalData.sharedInstance.userInfor?.user_info?.gender = 0
                                }else {
                                    GlobalData.sharedInstance.userInfor?.user_info?.gender = 1
                                }
                                
                            }
                            
                        }
                        self.updateAccountSuccess(true)
                    }
                }
                          
            } else {
                          
            }
        } failure: { error in
            
        }

        
    }
    
    
    func addViewChoiceSex(array: [String],indexChoice: Int){
        viewChoiceSex = Bundle.main.loadNibNamed("ChoiceItemView", owner: self, options: nil)?.first as? ChoiceItemView
        viewChoiceSex?.frame = CGRect(x: 132 , y: 350, width: 200, height: 34*2 + 32)
        viewChoiceSex?.delegate = self
        viewChoiceSex?.arrayItem = array
        viewChoiceSex?.indexChoice = indexChoice
        self.addSubview(viewChoiceSex!)
    }
   
    
}

extension EditAccountStudentTableViewCell : ChoiceItemViewDelegate {
    func choiceItem(indexChoice: Int, text: String) {
        sex = indexChoice
        labelSex.text = text
        viewChoiceSex?.removeFromSuperview()
    }
    
    
}
