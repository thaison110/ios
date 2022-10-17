//
//  CreateMedicineViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit
protocol CreateMedicineViewControllerDelegate {
    func updateArrayMedicine(array : [MedicineModel])
}
class CreateMedicineViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var viewBler: UIView!
    @IBOutlet weak var viewCreate: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var viewDatePicker: UIView!
   
    var dateBegin: Date?
    var dateEnd : Date?
    var arrayImage : [ImageLibraryModel]  = []
    var textNote = ""
    var delegate : CreateMedicineViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        setShadow()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.tabelView.register(UINib(nibName: "CreateMedicineNameTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineNameTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineImageTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineImageTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineNoteTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineTimeBeginTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineTimeBeginTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineSetDayTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineSetDayTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineRemindTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineRemindTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineAddRemindTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineAddRemindTableViewCell")
        self.tabelView.register(UINib(nibName: "CreateMedicineListImageTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineListImageTableViewCell")
        
      
        self.dateBegin = Double(Utilities.getCurrentTimestamp()).convertToDate()
        self.dateEnd = Double(Utilities.getCurrentTimestamp()).convertToDate()
        
    }
    
    func getTimeNow() -> String{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day,.month,.year], from: date)
        if let day = components.day,let month = components.month , let year = components.year {
            let timeNow = "\(day) tháng \(month), \(year)"
           return timeNow
        }
        return ""
        
       
        
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
        viewContent.layer.shadowOpacity = 0.7
        viewContent.layer.shadowRadius = 4.0
    }
    
    @IBAction func pressedDonePickerDate(_ sender: Any) {
        self.viewDatePicker.isHidden = true
        self.dateEnd = self.picker.date
        tabelView.reloadData()
    }
    @IBAction func pressedCreateMedicine(_ sender: Any) {
        self.sendMedice()
    }
    @IBAction func changePickerDate(_ sender: Any) {
        
    }
    func requestPermissionImage(){
        HandleMediaPicker().requestPermission(rootVC: self) {
            
            HandlePresent().showChoiceImageViewController(arrayImageChoice: self.arrayImage,root: self)
        }
    }
    
    func sendMedice() {
       
        var dateStart = ""
        if let time = dateBegin?.getDayMonthYearInt(){
            dateStart = "\(time.2)-\(time.1)-\(time.0)"
        }
        var date_End = ""
        if let time = dateEnd?.getDayMonthYearInt(){
            date_End = "\(time.2)-\(time.1)-\(time.0)"
        }
        
        var arrayImages : [String] = []
        for item in arrayImage {
            if let img = item.image {
                let image = "data:image/png;base64," + Common.convertImageToBase64String(img:img)
                arrayImages.append(image)
            }
            
        }
        
        
        
        let vc = ConfrimCreateMedicineViewController()
        vc.delegate = self
        vc.textNote = textNote
        vc.dateStart = dateStart
        vc.date_end = date_End
        vc.images = arrayImages
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
        
        
//        SVProgressHUD.show()
//        let service = MedicineService()
//        service.sendMedicine(textNote, date_start: dateStart, date_end: date_End, images: arrayImages) { response in
//            if let responseModel = MetaResponse(JSON: response){
//                if responseModel.status == 200 {
//                    var array : [MedicineModel] = []
//                    if let data = response["data"] as? [[String: Any]] {
//                        for item in data {
//                            if let obj = MedicineModel(JSON: item) {
//                                array.append(obj)
//                            }
//                        }
//                    }
//
//                    if let delegate = self.delegate {
//                        delegate.updateArrayMedicine(array: array)
//                        self.navigationController?.popViewController(animated: true)
//                    }
//
//                }
//
//            } else {
//
//            }
//            SVProgressHUD.dismiss()
//        } failure: { error in
//            SVProgressHUD.dismiss()
//        }

    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateMedicineViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineTimeBeginTableViewCell", for: indexPath) as! CreateMedicineTimeBeginTableViewCell
            
            if let date = dateBegin {
                if let time = date.getDayMonthYearInt() {
                    cell.labelTime.text = "\(time.0) tháng \(time.1) , \(time.2)"
                }
                
            }
            cell.labelTitle.text = "Ngày bắt đầu uống"
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineTimeBeginTableViewCell", for: indexPath) as! CreateMedicineTimeBeginTableViewCell
            if let date = dateEnd {
                if let time = date.getDayMonthYearInt() {
                    cell.labelTime.text = "\(time.0) tháng \(time.1) , \(time.2)"
                }
                
            }
            cell.labelTitle.text = "Đến ngày"
            cell.buttonChoiceDate.addTarget(self, action:#selector(choiceDate(_sender:)), for: .touchUpInside)
            cell.buttonChoiceDate.tag = indexPath.row
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineListImageTableViewCell", for: indexPath) as! CreateMedicineListImageTableViewCell
            if arrayImage.count > 0 {
                cell.cstHeightViewContent.constant = 187
                cell.viewContent.isHidden = false
                cell.setData(array: arrayImage)
            }else{
                cell.cstHeightViewContent.constant = 1
                cell.viewContent.isHidden = true
            }
            
            return cell
        }
        else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineImageTableViewCell", for: indexPath) as! CreateMedicineImageTableViewCell
            if arrayImage.count > 0 {
                cell.labelText.text = "Chỉnh sửa danh sách thuốc"
                cell.imageIcon.image = UIImage(named: "ic_EditGay")
                cell.cstWidthImage.constant = 15
            } else {
                cell.labelText.text = "Thêm thuốc"
                cell.imageIcon.image = UIImage(named: "ic_AddItemBLack")
                cell.cstWidthImage.constant = 20
            }
            return cell
        }
        else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineNoteTableViewCell", for: indexPath) as! CreateMedicineNoteTableViewCell
            cell.delegate = self
            
            return cell
        }
        
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            requestPermissionImage()
        }
    }
    @objc  func choiceDate(_sender: UIButton) {
        let index = _sender.tag
        if index == 1 {
            self.viewDatePicker.isHidden = false
            self.picker.minimumDate = dateBegin
        }
        
        
    }
}

extension CreateMedicineViewController : ContainerChoiceImaeFloatingViewControllerDelegate {
    func choiceListImage(listImage: [ImageLibraryModel]) {
        for item in listImage {
            item.getImageFormAsset()
        }
        arrayImage = listImage
        tabelView.reloadData()
    }
    
    
}

extension CreateMedicineViewController : CreateMedicineNoteTableViewCellDelegate {
    func updateTextNote(note: String) {
        self.textNote = note
        
        
        
   
        if note.count > 0 {
            self.viewBler.isHidden = true
        }else {
            self.viewBler.isHidden = false
        }
    }
}


extension CreateMedicineViewController : ConfrimCreateMedicineViewControllerDelegate {
    func updateArrayMedicine(array: [MedicineModel]) {
        self.navigationController?.popViewController(animated: true)
        if let delegate = self.delegate {
            delegate.updateArrayMedicine(array: array)
        }
    }
}
