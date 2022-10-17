//
//  PopupActiveDayViewController.swift
//  MamNon
//
//  Created by Thắng Trương on 25/09/2022.
//

import UIKit

class PopupActiveDayViewController: UIViewController {
    var dataActive:[ActivateModel] = []
    @IBOutlet weak var viewBackGround: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cstTop: NSLayoutConstraint!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    var date:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if date.count > 0 {
            self.getDataActiveDay (date: date)
        }
        self.initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        UIView.animate(withDuration: 2, delay: 0, options: [],
                       animations: {
            self.viewBackGround.isHidden = false
        },
            completion: nil
        )
    }
    
    func compareDate() -> Bool {
        let dateD = Common.convertStringToDate(dateString: date)
        let date = Date()
        return (dateD > date)
    }
    
    func getDay() -> (String,Bool) {
        let dateD = Common.convertStringToDate(dateString: date)
        let d:Double = dateD.timeIntervalSince1970
        let day = d.convertToDay()
        
        var isCheck = true
        if day == "T7" && day == "CN" {
            isCheck = false
        }
        
        return (day.replacingOccurrences(of: "T", with: "Thứ "),isCheck)
    }

    @IBAction func didSelectClose(_ sender: Any) {
        
//        UIView.animate(withDuration: 2, delay: 0, options: [],
//                       animations: {
//            self.viewBackGround.isHidden = true
//        }) { compre in
//            self.dismiss(animated: true)
//        }
        
        
        UIView.animate(withDuration: 5, delay: 0.1, options: .allowUserInteraction) {
            self.viewBackGround.isHidden = true
        } completion: { isCheck in
            self.dismiss(animated: true)
        }

       
       
    }
    
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.sectionHeaderHeight = UITableView.automaticDimension
        self.table.rowHeight = UITableView.automaticDimension
        self.table.register(UINib (nibName: "BoardHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "BoardHomeTableViewCell")
        self.table.register(UINib (nibName: "HeaderDateActiveDayTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderDateActiveDayTableViewCell")
    }
    
    func getDataActiveDay(date: String) {
        
        LeaveService().getDataActiveDay(date: date) { response in
            if let data = response["data"] as? [[String:Any]] {
                for item in data {
                    if let ac = ActivateModel (JSON: item) {
                        self.dataActive.append(ac)
                    }
                }
                self.viewInfo.isHidden = true
                if self.dataActive.count > 0 {
                    let height = (self.dataActive.count) * 60 + 40 + 48
                    self.cstTop.constant = SCREEN_HEIGHT - CGFloat(height)
                    self.view.layoutIfNeeded()
                }else {
                    
                    self.cstTop.constant = SCREEN_HEIGHT - 264
                    self.view.layoutIfNeeded()
                    self.viewInfo.isHidden = false
                    
                    if self.getDay().1 {
                        self.infoLabel.text = "Không có dữ liệu"
                    }else {
                        
                        self.infoLabel.text = "Ngày nghỉ cuối tuần"
                    }
                    
                    
                    
                }
                
            }
            self.table.reloadData()
        } failure: { err in
            
        }

    }

}

extension PopupActiveDayViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardHomeTableViewCell", for: indexPath) as! BoardHomeTableViewCell
        cell.configCell(data: self.dataActive)
        cell.icArrow.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDateActiveDayTableViewCell") as! HeaderDateActiveDayTableViewCell
        cell.titleLabel.text = "\(getDay().0),\(Common.convertDateYYYYMMddToDDMMYYYY(dateString: self.date))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataActive.count > 0 {
            let height = (self.dataActive.count) * 60 + 40
            return CGFloat(height)
        }
        return 0
    }
    
}
