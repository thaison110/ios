//
//  IndexViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 24/09/2022.
//

import UIKit

class IndexViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tabelView: UITableView!
    var arrayHealth : [HealthModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        addViewHeader()
        self.tabelView.register(UINib(nibName: "IndexInforTableViewCell", bundle: nil), forCellReuseIdentifier: "IndexInforTableViewCell")
        self.tabelView.register(UINib(nibName: "IndexHeightAndWeightTableViewCell", bundle: nil), forCellReuseIdentifier: "IndexHeightAndWeightTableViewCell")
        self.tabelView.register(UINib(nibName: "IndexChartTableViewCell", bundle: nil), forCellReuseIdentifier: "IndexChartTableViewCell")
        self.tabelView.register(UINib(nibName: "IndexSaveAndShareTableViewCell", bundle: nil), forCellReuseIdentifier: "IndexSaveAndShareTableViewCell")
        
        getDataHealth()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
        // Do any additional setup after loading the view.
    }

    
    @objc private func refreshUpdateData() {
        
        self.getDataHealth()
        self.refreshControl.endRefreshing()
        
    }

    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    
    func getDataHealth() {
        let service = IndexService()
        service.getDataHealth(2022) { response in
            if let responseModel = MetaResponse(JSON: response) {
                if responseModel.status == 200 {
                    var array : [HealthModel] = []
                    if let data = response["data"] as? [[String : Any]] {
                        for item in data {
                            if let obj = HealthModel(JSON: item){
                                array.append(obj)
                            }
                            
                        }
                    }
//                    if let obj = HealthModel(JSON: [:]){
//                        obj.date = 1664030513;
//                        obj.height = 135
//                        obj.weight = 26
//                        array.append(obj )
//                    }
//                    
//                    if let obj = HealthModel(JSON: [:]){
//                        obj.date = 1664203230;
//                        obj.height = 123
//                        obj.weight = 30
//                        array.append(obj )
//                    }
                    
                    
                    self.arrayHealth = array
                    self.tabelView.reloadData()
                }
               
            } else {
               
            }
        } failure: { error in
            
        }

    }

    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension IndexViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayHealth.count > 0 {
            return 4
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IndexInforTableViewCell", for: indexPath) as! IndexInforTableViewCell
            if let obj = GlobalData.sharedInstance.userInfor {
                cell.imageAvatar.sd_setImage(with: URL(string: obj.user_info?.avatar ?? ""), placeholderImage: UIImage(named: "ic_AvatarDefaul"))
                cell.labelName.text = obj.user_info?.fullname
                cell.labelBirthday.text = "Ngày sinh: " + Common.convertDateYMDToDMY(date: (obj.user_info?.birthday ?? ""), separatorOut: "-") 
            }
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IndexHeightAndWeightTableViewCell", for: indexPath) as! IndexHeightAndWeightTableViewCell
            let obj = arrayHealth[arrayHealth.count - 1]
            cell.setData(obj: obj)
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IndexChartTableViewCell", for: indexPath) as! IndexChartTableViewCell
            
            cell.setData(array: arrayHealth)
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IndexSaveAndShareTableViewCell", for: indexPath) as! IndexSaveAndShareTableViewCell
            return cell
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
