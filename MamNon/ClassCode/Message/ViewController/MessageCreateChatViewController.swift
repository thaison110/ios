//
//  MessageCreateChatViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 17/09/2022.
//

import UIKit

class MessageCreateChatViewController: UIViewController {
    @IBOutlet weak var textFieldSreach: UITextField!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewHeader: UIView!
    var arrayChatPersion : [ChatPersonModel] = []
    var arrayChatPersionSreach : [ChatPersonModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewHeader()
        setShadow()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        // Do any additional setup after loading the view.
        self.tabelView.register(UINib(nibName: "CreatePresonChatItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CreatePresonChatItemTableViewCell")
        arrayChatPersionSreach = arrayChatPersion
        getListTeacher()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
    }
    
    @objc private func refreshUpdateData() {
        
        getListTeacher()
        self.refreshControl.endRefreshing()
        
    }

    func setShadow(){
        // corner radius
        viewContent.layer.cornerRadius = 12

        // border
        viewContent.layer.borderWidth = 1.0
        viewContent.layer.borderColor = UIColor.white.cgColor

        // shadow
        viewContent.layer.shadowColor = UIColor.lightGray.cgColor
        viewContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewContent.layer.shadowOpacity = 0.7
        viewContent.layer.shadowRadius = 4.0
    }
    
    @IBAction func changeTextSreach(_ sender: Any) {
       
        sreachChat()
    }
    
    func sreachChat(){
        if textFieldSreach.text?.count ?? 0 > 0 {
            if let textSreach = textFieldSreach.text  {
                var array :[ChatPersonModel ] = []
                for item in arrayChatPersion {
                    if item.name.contains(textSreach){
                        array.append(item)
                    }
                }
                arrayChatPersionSreach = array
                tabelView.reloadData()
            }
        }else{
            arrayChatPersionSreach = arrayChatPersion
            tabelView.reloadData()
        }
        
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addViewHeader(){
        let header = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView
        header?.setupUI(rootView: viewHeader)
        viewHeader.addSubview(header!)
    }
    
    func getListTeacher(){
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
                    self.arrayChatPersion = array
                    self.sreachChat()
                }
            }
        } failure: { error in
            
        }

    }

}

extension MessageCreateChatViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayChatPersionSreach.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreatePresonChatItemTableViewCell", for: indexPath) as! CreatePresonChatItemTableViewCell
        cell.getData(obj: arrayChatPersionSreach[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HandlePush().pushToMessageDetail(personChat: arrayChatPersionSreach[indexPath.row],root: self)
    }
}
