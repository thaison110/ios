//
//  HistoryPickUpViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 22/09/2022.
//

import UIKit

class HistoryPickUpViewController: UIViewController {
    @IBOutlet weak var labelMonthHistory: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    var arrayHisstoryPickUpAll: [HistoryPickUpModel] = []
    var arrayHisstoryPickUpMonth : [HistoryPickUpModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    var monthNext: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.tabelView.register(UINib(nibName: "PickUpHistoryItemTableViewCell", bundle: nil), forCellReuseIdentifier: "PickUpHistoryItemTableViewCell")
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
        getListHistoryPickUp()
        let timestamp = Utilities.getCurrentTimestamp()
        labelMonthHistory.text = "Tháng " + (Double(timestamp).convertToDate().getMonthAndYear() ?? "")
    }
    
    @objc private func refreshUpdateData() {
        
        getListHistoryPickUp()
        self.refreshControl.endRefreshing()
        
    }
    

    func getListHistoryPickUp(){
        SVProgressHUD.show()
        let pickUpService = PickUpService()
        pickUpService.getHistoryPickUp { response in
            if let responseModel = MetaResponse(JSON: response) {
                if responseModel.status == 200 {
                    if let data = response["data"] as? [[String : Any]]{
                        var array: [HistoryPickUpModel] = []
                        for item in data {
                            if let obj = HistoryPickUpModel(JSON: item) {
                                array.append(obj)
                            }
                           
                        }
                        self.arrayHisstoryPickUpAll = array
                        self.arrayHisstoryPickUpMonth = Common.getHistoryPickUpByMonth(monthNext: self.monthNext, arrayHisstoryPickUpAll: self.arrayHisstoryPickUpAll)
                        self.tabelView.reloadData()
                      
                    }
                }
            }
            
           
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
    @IBAction func pressedNextMonth(_ sender: Any) {
        self.monthNext = monthNext + 1
        let timestamp = Utilities.getCurrentTimestamp()
        labelMonthHistory.text = "Tháng " + (Double(timestamp).convertToDate().getPreviousOrNextMonth(value: monthNext)?.getMonthAndYear() ?? "")
        arrayHisstoryPickUpMonth =  Common.getHistoryPickUpByMonth(monthNext: monthNext, arrayHisstoryPickUpAll: arrayHisstoryPickUpAll)
        tabelView.reloadData()
    }
    
    @IBAction func pressedBackMonth(_ sender: Any) {
        self.monthNext = monthNext - 1
        let timestamp = Utilities.getCurrentTimestamp()
        labelMonthHistory.text = "Tháng " + (Double(timestamp).convertToDate().getPreviousOrNextMonth(value: monthNext)?.getMonthAndYear() ?? "")
        arrayHisstoryPickUpMonth =   Common.getHistoryPickUpByMonth(monthNext: monthNext, arrayHisstoryPickUpAll: arrayHisstoryPickUpAll)
        tabelView.reloadData()
    }
    
}

extension HistoryPickUpViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayHisstoryPickUpMonth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickUpHistoryItemTableViewCell", for: indexPath) as! PickUpHistoryItemTableViewCell
        cell.setDataHistoryCreatePickUp(obj: arrayHisstoryPickUpMonth[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
