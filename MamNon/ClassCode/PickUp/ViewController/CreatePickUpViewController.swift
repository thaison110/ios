//
//  CreatePickUpViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit

protocol CreatePickUpViewControllerDelegate {
    func updateListHistoryPickUp(array: [HistoryPickUpModel])
}

class CreatePickUpViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var labelPesonPickUp: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelPlaceHoder: UILabel!
    @IBOutlet weak var textViewNote: UITextView!
    @IBOutlet weak var imagePickUp: UIImageView!
    @IBOutlet weak var labelPickUp: UILabel!
    var delegate : CreatePickUpViewControllerDelegate?
    var arrayShuttlePerson : [ShuttlePersonModel] = []
    var indexChoicePersonPickUp  = 0
    var viewChoiceTimePickUpView : ChoiceTimePickUpView?
    var viewChoicePersonPickUp: ChoiceItemView?
    var typeTimePickUp = 0 // 0 đúng giờ, 1 sớm, 2 muộn
    var datePickUp = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewHeader()
        setShadow()
        self.textViewNote.delegate = self
        // Do any additional setup after loading the view.
        setDataViewTimePickUp(type: typeTimePickUp)
        getListShuttlePerson()
        getTimePickUp()
    }
    
    


    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func addViewChoiceTime(){
         viewChoiceTimePickUpView = Bundle.main.loadNibNamed("ChoiceTimePickUpView", owner: self, options: nil)?.first as? ChoiceTimePickUpView
        viewChoiceTimePickUpView?.frame = CGRect(x: 0, y: 98 + Common.getTopPadding(), width: SCREEN_WIDTH, height: 68*3 + 32)
        viewChoiceTimePickUpView?.delegate = self
        self.view.addSubview(viewChoiceTimePickUpView!)
    }
    
    
    func addViewChoicePersonPickup(array: [String],indexChoice: Int){
        viewChoicePersonPickUp = Bundle.main.loadNibNamed("ChoiceItemView", owner: self, options: nil)?.first as? ChoiceItemView
        viewChoicePersonPickUp?.frame = CGRect(x: SCREEN_WIDTH - 242 , y: 240 + 44 + Common.getTopPadding(), width: 242, height: 34*3 + 32)
        viewChoicePersonPickUp?.delegate = self
        viewChoicePersonPickUp?.arrayItem = array
        viewChoicePersonPickUp?.indexChoice = indexChoice
        self.view.addSubview(viewChoicePersonPickUp!)
    }
    
    func setDataViewTimePickUp(type: Int){
        if type == 0 {
            self.imagePickUp.image = UIImage(named: "ic_PickUpOnTime")
            labelPickUp.text = "Đón đúng giờ"
            labelPickUp.textColor = UIColor.init(hexString: "#27AE60")
            self.labelTime.text = "17:30"
        }else if type == 1 {
            imagePickUp.image = UIImage(named: "ic_PickUpEarly")
            labelPickUp.text = "Đón sớm"
            labelPickUp.textColor = UIColor.init(hexString: "#FF7917")
            self.labelTime.text = "16:30"
        }else{
            imagePickUp.image = UIImage(named: "ic_PickUpLate")
            labelPickUp.text = "Đón muộn"
            labelPickUp.textColor = UIColor.init(hexString: "#FF5959")
            self.labelTime.text = "18:30"
        }
    }
    
    @IBAction func pressedShowChoicePersonPickup(_ sender: Any) {
        var arrayName : [String] = []
        for item in arrayShuttlePerson {
            arrayName.append(setNamePersonPickUp(obj: item))
        }
//        HandlePresent().showPickerViewChoiceViewController(indexChoice: indexChoicePersonPickUp, arrayChoice: arrayName, root: self)
        self.addViewChoicePersonPickup(array: arrayName, indexChoice: indexChoicePersonPickUp)
    }
    @IBAction func pressedShowViewChoiceTime(_ sender: Any) {
        self.addViewChoiceTime()
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
    
    func setNamePersonPickUp(obj: ShuttlePersonModel) -> String{
        var name = ""
        name = arrayPersonPickUpDefaul[obj.relationship ?? 0] + " (" + obj.name + ")"
        
        return name
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textViewNote.text.count > 0 {
            labelPlaceHoder.isHidden = true
        }else{
            labelPlaceHoder.isHidden = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
    
    func getListShuttlePerson(){
        SVProgressHUD.show()
        let pickUpService = PickUpService()
        pickUpService.getListPersonPickUp { response in
            if let responseModel = MetaResponse(JSON: response){
                if let data = response["data"] as? [[String : Any]]{
                    var array: [ShuttlePersonModel] = []
                    for item in data {
                        if let obj = ShuttlePersonModel(JSON: item) {
                            array.append(obj)
                        }
                        
                    }
                    self.arrayShuttlePerson = array
                    if array.count > 0 {
                        let obj = array[0]
                        self.labelPesonPickUp.text = self.setNamePersonPickUp(obj: obj)
                    }
                }
              
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
    
    func getTimePickUp(){
        let timeNow = Double(Utilities.getCurrentTimestamp())
        
        if timeNow.convertToDay() == "CN" {
            if let date = timeNow.convertToDate().getPreviousOrNextDay(value: 1) {
                labelDate.text = getTimeDayPickUp(date: date)
            }
        }else {
            if let time = timeNow.convertToDate().getTimeHHMMSS() {
                var isNextDay = false
                if typeTimePickUp == 0 {
                    if time.0*60 + time.1 >= 17*60 + 30 {
                        isNextDay = true
                    }
                }else if typeTimePickUp == 1 {
                    if time.0*60 + time.1 >= 16*60 + 30 {
                        isNextDay = true
                    }
                }else if typeTimePickUp == 2 {
                    if time.0*60 + time.1 >= 18*60 + 30 {
                        isNextDay = true
                    }
                }
                
                if isNextDay {
                    if timeNow.convertToDay() == "T7" {
                        if let date = timeNow.convertToDate().getPreviousOrNextDay(value: 2) {
                            labelDate.text = getTimeDayPickUp(date: date)
                        }
                    }
                }else{
                    labelDate.text = getTimeDayPickUp(date: Date())
                }
            }
            
        }
    }
    
    func getTimeDayPickUp(date: Date) -> String{
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: date)
        if let day = components.day,let month = components.month , let year = components.year {
            let timeNow = "\(day) tháng \(month), \(year)"
            datePickUp = "\(year)-\(month)-\(day)"
           return timeNow
        }
        return ""
        
       
        
    }
    @IBAction func pressedCreatePickUp(_ sender: Any) {
        self.createPickUp()
    }
    
    func createPickUp(){
        let pickUpService = PickUpService()
        pickUpService.createPickUp(textViewNote.text ?? "", type: typeTimePickUp, date: datePickUp, hour: labelTime.text ?? "17:30", homie_id: arrayShuttlePerson[indexChoicePersonPickUp].id ?? 0) { response in
            if let data = response["data"] as? [[String : Any]]{
                var array: [HistoryPickUpModel] = []
                for item in data {
                    if let obj = HistoryPickUpModel(JSON: item) {
                        array.append(obj)
                    }
                    
                }
                if let delegate = self.delegate {
                    delegate.updateListHistoryPickUp(array: array)
                    self.navigationController?.popViewController(animated: true)
                }
              
            }
        } failure: { error in
            
        }

    }
    
}

extension CreatePickUpViewController : ChoiceTimePickUpViewDelegate {
    func choiceIndexTime(index: Int) {
        typeTimePickUp = index
        
        setDataViewTimePickUp(type: typeTimePickUp)
        
        self.viewChoiceTimePickUpView?.removeFromSuperview()
    }
}

extension CreatePickUpViewController : PickerViewChoiceViewControllerDelegate {
    func choiceItem(index: Int, text: String) {
        indexChoicePersonPickUp = index
        let obj = arrayShuttlePerson[indexChoicePersonPickUp]
        self.labelPesonPickUp.text = self.setNamePersonPickUp(obj: obj)
    }
}

extension CreatePickUpViewController : ChoiceItemViewDelegate {
    func choiceItem(indexChoice: Int, text: String) {
        indexChoicePersonPickUp = indexChoice
        let obj = arrayShuttlePerson[indexChoicePersonPickUp]
        self.labelPesonPickUp.text = self.setNamePersonPickUp(obj: obj)
        self.viewChoicePersonPickUp?.removeFromSuperview()
    }
}
