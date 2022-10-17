//
//  NewsViewController.swift
//  MamNon
//
//  Created by Thắng Trương on 22/09/2022.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var table: UITableView!
    var data:[NewsModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewHeader()
        self.initTable()
        self.getData()
        self.table.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
    }

    @objc private func refreshUpdateData() {
        
        self.getData()
        self.refreshControl.endRefreshing()
        
    }
  
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorColor = .clear
        
        self.table.register(UINib (nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        
    }
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }

    func getData() {
        SVProgressHUD.show()
        NewsService().getDataNews { response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200 {
                    
                    if let data = response["data"] as? [[String:Any]] {
                        var array : [NewsModel] = []
                        for item in data {
                            if let model = NewsModel (JSON: item) {
                                array.append(model)
                            }
                            
                        }
                        self.data = array
                        self.table.reloadData()
                    }
                }
                
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { err in
            SVProgressHUD.dismiss()
        }

        
    }
    

    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.data[indexPath.section]
        let cell = table.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configCell(news: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HandlePush().pushDetailNews(root: self, newsModel: self.data[indexPath.section])
    }
    
    
}
