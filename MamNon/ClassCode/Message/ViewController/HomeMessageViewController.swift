//
//  HomeMessageViewController.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 16/09/2022.
//

import UIKit

class HomeMessageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    var arrayChatPersion : [ChatPersonModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewHeader()
        // Do any additional setup after loading the view.
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.register(UINib(nibName: "MessagePresonTableViewCell", bundle: nil), forCellReuseIdentifier: "MessagePresonTableViewCell")
        getListTeacher()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
    }
    
    @objc private func refreshUpdateData() {
        
        getListTeacher()
        self.refreshControl.endRefreshing()
        
    }


    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChatPersion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagePresonTableViewCell", for: indexPath) as! MessagePresonTableViewCell
        cell.getData(obj: arrayChatPersion[indexPath.row])
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HandlePush().pushToMessageDetail(personChat: arrayChatPersion[indexPath.row],root: self)
    }
    
    func getListTeacher(){
        SVProgressHUD.show()
        let messageService = MessageService()
        messageService.getListTeacher { [self] response in
            if let responseModel = MetaResponse(JSON: response){
                if responseModel.status == 200{
                    var array : [ChatPersonModel] = []
                    if let data  = response["data"] as? [[String: Any]]{
                        for item  in data {
                            if let obj = ChatPersonModel(JSON: item){
                                array.append(obj)
                            }
                           
                        }
                    }
//                    self.loadArrayChat(array: array)
                    self.arrayChatPersion = array
                    self.tabelView.reloadData()
                }
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }

    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pressedCreateChat(_ sender: Any) {
        HandlePush().pushToMessageCreateChat(arrayPersonChat: arrayChatPersion, root: self)
    }
    func loadArrayChat(array: [ChatPersonModel]){
        var arrayLast : [ChatPersonModel] = []
        for item in array {
            if item.text_last.count > 0{
                arrayLast.append(item)
            }
        }
        self.arrayChatPersion = arrayLast
    }
}
