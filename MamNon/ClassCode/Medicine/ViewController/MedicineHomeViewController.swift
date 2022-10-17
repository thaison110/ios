//
//  MedicineHomeViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 19/09/2022.
//

import UIKit

class MedicineHomeViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    var arrayMedicine : [MedicineModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.tabelView.register(UINib(nibName: "MedicineHomeItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicineHomeItemTableViewCell")
        self.getData()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
    }

    @objc private func refreshUpdateData() {

        self.getData()
        self.refreshControl.endRefreshing()

    }
   
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressedCreateMedicine(_ sender: Any) {
        HandlePush().pushToCreateMedicine(root: self)
    }
    
    func getData() {
        let service = MedicineService()
        SVProgressHUD.show()
        service.getMedicineHistory { response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200 {
                    var array : [MedicineModel] = []
                    if let data = response["data"] as? [[String: Any]] {
                        for item in data {
                            if let obj = MedicineModel(JSON: item) {
                                array.append(obj)
                            }
                        }
                    }
                    self.arrayMedicine = array
                    self.tabelView.reloadData()
                    
                    
                }
               
            } else {
               
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
}


extension MedicineHomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMedicine.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineHomeItemTableViewCell", for: indexPath) as! MedicineHomeItemTableViewCell
        cell.setData(obj: arrayMedicine[indexPath.row])
        cell.buttonClick.addTarget(self, action:#selector(didDeselect(_sender:)), for: .touchUpInside)
        cell.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       
    }
    @objc  func didDeselect(_sender: UIButton) {
        let index = _sender.tag
        HandlePush().pushMedicineDetailViewController(objMedicine: arrayMedicine[index], root: self)
        
        
    }
}

extension MedicineHomeViewController : CreateMedicineViewControllerDelegate {
    func updateArrayMedicine(array: [MedicineModel]) {
        self.arrayMedicine = array
        self.showToast(message: "Đã tạo Thuốc thành công!")
        self.tabelView.reloadData()
    }
}

extension MedicineHomeViewController : MedicineDetailViewControllerDelete {
    func deleteMedicine(obj: MedicineModel) {
        for i in 0..<self.arrayMedicine.count {
            if obj.id == self.arrayMedicine[i].id {
                arrayMedicine.remove(at: i)
                break
            }
        }
        self.tabelView.reloadData()
    }
}
