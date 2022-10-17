//
//  MedicineDetailViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 01/10/2022.
//

import UIKit
protocol MedicineDetailViewControllerDelete {
    func deleteMedicine(obj: MedicineModel)
}

class MedicineDetailViewController: UIViewController {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    var delete : MedicineDetailViewControllerDelete?
    var objMedicine : MedicineModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.tabelView.register(UINib(nibName: "CreateMedicineListImageTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateMedicineListImageTableViewCell")
        self.tabelView.register(UINib(nibName: "MedicineDetailHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineDetailHeaderTableViewCell")
        self.tabelView.register(UINib(nibName: "MedicineDetailNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineDetailNoteTableViewCell")
        
        
        
        self.addViewHeader()
        self.setShadow()
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
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressedDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Xác nhận xoá", message: "Xóa thuốc này khỏi danh sách thuốc trong dặn thuốc?", preferredStyle: UIAlertController.Style.alert)

               // add the actions (buttons)\
        alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Xoá", style: UIAlertAction.Style.default, handler: { item in
            self.deleteMedicine()
        }))
        

               // show the alert
        self.present(alert, animated: true, completion: nil)
        
        
       
        

    }
    
    func deleteMedicine() {
        if let id = objMedicine?.id{
            let service = MedicineService()
            SVProgressHUD.show()
            service.deleteMedicine(id) { [self] response in
                if let responseModel = MetaResponse(JSON: response){
                    if responseModel.status == 200 {
                        if let delete = self.delete , let obj = self.objMedicine {
                            delete.deleteMedicine(obj: obj)
                        }
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                SVProgressHUD.dismiss()
            } failure: { error in
                SVProgressHUD.dismiss()
            }
        }
    }
}


extension MedicineDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineDetailHeaderTableViewCell", for: indexPath) as! MedicineDetailHeaderTableViewCell
            if let obj = objMedicine {
                cell.setData(obj: obj)
            }
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateMedicineListImageTableViewCell", for: indexPath) as! CreateMedicineListImageTableViewCell
            if let obj = objMedicine {
                if obj.image.count > 0 {
                    cell.cstHeightViewContent.constant = 187
                    cell.viewContent.isHidden = false
                    if let obj = objMedicine {
                        cell.setDataDetail(obj: obj)
                    }
                   
                }else{
                    cell.cstHeightViewContent.constant = 1
                    cell.viewContent.isHidden = true
                }
            }
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineDetailNoteTableViewCell", for: indexPath) as! MedicineDetailNoteTableViewCell
            
            if let obj = objMedicine {
                cell.labelNote.text = obj.note
            }else {
                cell.labelNote.text = ""
            }
            return cell
        }
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
