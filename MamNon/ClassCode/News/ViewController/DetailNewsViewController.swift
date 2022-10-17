//
//  DetailNewsViewController.swift
//  MamNon
//
//  Created by Truong Thang on 22/09/2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var table: UITableView!
    var newsModel:NewsModel?
//    var detailNewsModel:DetailNewsModel?
    var idPostNotifi : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initTable()
        if idPostNotifi != nil {
            self.getDetailData(id: idPostNotifi ?? 0)
        }else{
            self.getDetailData(id: self.newsModel?.id ?? 0)
        }
       
        self.addViewHeader()
        
    }

    
    func initTable() {
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorColor = .clear
        self.table.sectionHeaderHeight = UITableView.automaticDimension
        self.table.rowHeight = UITableView.automaticDimension
        self.table.register(UINib (nibName: "WebViewNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "WebViewNewsTableViewCell")
        self.table.register(UINib (nibName: "HeaderDetailNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderDetailNewsTableViewCell")
        self.table.register(UINib (nibName: "DetailImageTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailImageTableViewCell")
        

    }
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }

    
    func getDetailData(id: Int) {
        NewsService().getDataDetailNews(id: id) { response in
            if let data = response["data"] as? [String:Any] {
                let newsModel = NewsModel (JSON: data)
                self.newsModel = newsModel
                self.table.reloadData()
            }
        } failure: { err in
            
        }
    }
    
    

    
    @IBAction func didSelectBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DetailNewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.newsModel?.image.count ?? 0 > 0 {
            if (self.newsModel?.detail?.count ?? 0) > 0 {
                return 2
            }
        }else {
            if (self.newsModel?.detail?.count ?? 0) > 0 {
                return 1
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.newsModel?.image.count ?? 0 > 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageTableViewCell", for: indexPath) as! DetailImageTableViewCell
                cell.avatarImage.sd_setImage(with: URL (string: newsModel?.image ?? ""))
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebViewNewsTableViewCell", for: indexPath) as! WebViewNewsTableViewCell
        cell.configCell(newsModel: self.newsModel)
        cell.updateHeightLoadWebView = {[weak self] in
            self?.table.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDetailNewsTableViewCell") as! HeaderDetailNewsTableViewCell
        cell.configCell(newsModel: self.newsModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.newsModel?.image.count ?? 0 > 0 {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            }
        }
        return self.newsModel?.height ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
