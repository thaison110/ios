//
//  ConfrimCreateMedicineViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 01/10/2022.
//

import UIKit

protocol ConfrimCreateMedicineViewControllerDelegate {
    func updateArrayMedicine(array : [MedicineModel])
}

class ConfrimCreateMedicineViewController: UIViewController {
    var delegate : ConfrimCreateMedicineViewControllerDelegate?
    var textNote : String = ""
    var dateStart : String = ""
    var date_end : String = ""
    var images : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pressedBack(_ sender: Any) {
        self.dismiss(animated: false)
        
    }
    
    @IBAction func pressedOK(_ sender: Any) {
        
        self.sendMedicine()
    }
    
    func sendMedicine ()  {
        let service = MedicineService()
        service.sendMedicine(textNote, date_start: dateStart, date_end: date_end, images: images) { response in
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
                    
                    if let delegate = self.delegate {
                        delegate.updateArrayMedicine(array: array)
                        self.dismiss(animated: false)
                    }
                    
                }
               
            } else {
               
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }
    }

}
