//
//  NotificationViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    var fpc: FloatingPanelController!
    var arrayNotifi : [NotificationModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewHeader()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.register(UINib(nibName: "NotificationItemTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationItemTableViewCell")
        self.tabelView.register(UINib(nibName: "NotificationHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationHeaderTableViewCell")
        
        self.getData()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
        // Do any additional setup after loading the view.
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
    
    func getData() {
        SVProgressHUD.show()
        let service = NotificationService()
        service.getListNotificaton { response in
            SVProgressHUD.dismiss()
            if let responseModel = MetaResponse(JSON: response) {
                if responseModel.status == 200 {
                    var array : [NotificationModel] = []
                    if let data = response["data"] as? [[String : Any]] {
                        for item in data {
                            if let obj = NotificationModel(JSON: item){
                                array.append(obj)
                            }
                                
                        }
                    }
                    self.arrayNotifi = array
                    self.tabelView.reloadData()
                }
            }
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
}

extension NotificationViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNotifi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationItemTableViewCell", for: indexPath) as! NotificationItemTableViewCell
        cell.setdata(obj: arrayNotifi[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationHeaderTableViewCell") as! NotificationHeaderTableViewCell
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrayNotifi[indexPath.row]
        /*
        [
           0 => 'Hoạt động đón trả',
           1 => 'Duyệt đơn phép',
           2 => 'Duyệt dơn dặn thuốc',
           3 => 'Duyệt đơn đón về',
           4 => 'Tin tức'
        ]
         */
        
        if obj.type == 4 { // tin tức
            if obj.detail.count > 0 {
                HandlePresent().showPopupNotificationDetail(objNotifi: obj,root: self)
            }else {
                HandlePush().pushDetailNews(root: self, idPost: obj.item_id)
            }
            
        }
        
    }
}
