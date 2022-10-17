//
//  HomeViewController.swift
//  MamNon
//
//  Created by Truong Thang on 15/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classlabel: UILabel!
    @IBOutlet weak var contentUserView: UIView!
    
    @IBOutlet weak var viewHeader: UIView!
    let viewModel = HomeViewModel()
    var data:[HomeModel] = []
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTable()
        self.handleData()
        self.setData()
        self.setLayout()
        self.setShadow()
        self.addViewHeader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if GlobalData.sharedInstance.arrayFeaturePin.count > 0 {
            let model = self.data.first(where: {$0.typeHome == .Utiliti})
            model?.arrayFeaturePin = GlobalData.sharedInstance.arrayFeaturePin
            self.table.reloadData()
        }
        
    }
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorColor = .clear
        self.table.register(UINib (nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        self.table.register(UINib (nibName: "BoardHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "BoardHomeTableViewCell")
        self.table.register(UINib (nibName: "UtilitiHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "UtilitiHomeTableViewCell")
        self.table.register(UINib (nibName: "HeaderUtilitiHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderUtilitiHomeTableViewCell")
        
    }
    
    func setShadow(){
        // corner radius
        contentUserView.layer.cornerRadius = 12

        // border
        contentUserView.layer.borderWidth = 1.0
        contentUserView.layer.borderColor = UIColor.white.cgColor

        // shadow
        contentUserView.layer.shadowColor = UIColor.lightGray.cgColor
        contentUserView.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentUserView.layer.shadowOpacity = 0.6
        contentUserView.layer.shadowRadius = 4.0
       
    }
    
    func setLayout() {
//        self.contentUserView.layer.cornerRadius = 12
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width/2
        
    }
    
    func setData() {
        self.nameLabel.text = GlobalData.sharedInstance.userInfor?.user_info?.fullname ?? ""
        self.avatarImage.sd_setImage(with: URL (string: GlobalData.sharedInstance.userInfor?.user_info?.avatar ?? ""), placeholderImage: UIImage (named: "ic_AvatarDefaul"))
        self.classlabel.text = GlobalData.sharedInstance.userInfor?.user_info?.Class ?? ""
    }
    
    func handleData() {
        
        let home = HomeModel()
        home.typeHome = .Utiliti
        home.titleHeader = "Tiện ích nhanh"
        home.titleButton = "Chỉnh sửa"
        if GlobalData.sharedInstance.arrayFeaturePin.count > 0 {
            home.arrayFeaturePin = GlobalData.sharedInstance.arrayFeaturePin
        }
        self.data.append(home)
        
        if var active = GlobalData.sharedInstance.userInfor?.activate {
//            if active.count < 1 {
//                for _ in 0...3 {
//                    if let ac = ActivateModel (JSON: [:]) {
//                        ac.title = "Bé ăn sáng"
//                        ac.note = "sữa chua, cháo thị băm, dưa hấu tráng miệng"
//                        ac.time = "09:07"
//                        active.append(ac)
//                    }
//
//                }
//            }
            
            let home1 = HomeModel ()
            home1.typeHome = .Activate
            home1.titleHeader = "Bảng tin"
            home1.titleButton = "Tất cả"
            home1.activate = active
            self.data.append(home1)
        }
        if (GlobalData.sharedInstance.userInfor?.news.count ?? 0) > 0 {
            let home2 = HomeModel ()
            home2.typeHome = .News
            home2.titleHeader = ""
            home2.news = GlobalData.sharedInstance.userInfor?.news
            self.data.append(home2)
        }
        
        self.table.reloadData()
    }

    @IBAction func didSelectProfile(_ sender: Any) {
            
        self.tabBarController?.selectedIndex = 3
    }
    

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.data[section]
        if model.typeHome == .Utiliti {
            return 1
        }else if model.typeHome == .News {
            return model.news?.count ?? 0
        }else if model.typeHome == .Activate {
            if model.activate?.count ?? 0 > 0 {
                return 1
            }
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.data[indexPath.section]
        if model.typeHome == .Utiliti {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UtilitiHomeTableViewCell", for: indexPath) as! UtilitiHomeTableViewCell
            cell.configCell(data: model.arrayFeaturePin)
            return cell

        }else if model.typeHome == .News {
            let cell = table.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            let obj = model.news?[indexPath.row]
            cell.configCell(news: obj)
            return cell
        }else if model.typeHome == .Activate {
            let cell = table.dequeueReusableCell(withIdentifier: "BoardHomeTableViewCell", for: indexPath) as! BoardHomeTableViewCell
            cell.configCell(data: model.activate)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.data[indexPath.section]
        if model.typeHome == .Utiliti {
            return 90
        }else if model.typeHome == .Activate {
            if model.activate?.count ?? 0 > 0 {
                let height = (model.activate?.count ?? 0) * 60 + 40
                return CGFloat(height)
            }
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = self.data[section]
        if model.typeHome == .News {
            return 0.01
        }else if model.typeHome == .Activate {
            if model.activate?.count ?? 0 < 1 {
                return 0.01
            }
            
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.data[section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderUtilitiHomeTableViewCell") as! HeaderUtilitiHomeTableViewCell
        cell.configCell(data: model)
        cell.seeMore = {[weak self] data in
//            if let tabBarController = self?.tabBarController as? UITabBarController {
//
//                tabBarController.selectedIndex = 1
//            }
            if let root = self {
                HandlePresent().showFeatureViewController(isEdit: true, root: root )
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.data[indexPath.section]
        if model.typeHome == .News {
            HandlePush().pushDetailNews(root: self, newsModel: model.news?[indexPath.row])
        }
        
    }

}

extension HomeViewController: FeatureViewControllerDelegate {
    func updateFeaturePin() {
        self.viewDidAppear(false)
    }
}
