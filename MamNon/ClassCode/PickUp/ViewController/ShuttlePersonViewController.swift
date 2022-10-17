//
//  ShuttlePersonViewController.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 20/09/2022.
//

import UIKit

class ShuttlePersonViewController: UIViewController {

    @IBOutlet weak var tabelView: UITableView!
    var arrayShuttlePerson : [ShuttlePersonModel] = []
    var  refreshControl : UIRefreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.register(UINib(nibName: "ShuttlePersonItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ShuttlePersonItemTableViewCell")
        tabelView.register(UINib(nibName: "ShuttlePersonNoteSchoolTableViewCell", bundle: nil), forCellReuseIdentifier: "ShuttlePersonNoteSchoolTableViewCell")
        
        // Do any additional setup after loading the view.
        self.getListShuttlePerson()
        self.tabelView.addSubview(refreshControl)
        self.refreshControl.addTarget(self, action: #selector(refreshUpdateData), for: .valueChanged)
    }

    @objc private func refreshUpdateData() {
        
        getListShuttlePerson()
        self.refreshControl.endRefreshing()
        
    }
   
    @IBAction func pressedCreateShuttlePreson(_ sender: Any) {
        HandlePush().pushToCreateShuttlePerson(root: self)
    }
    
    func getListShuttlePerson(){
        SVProgressHUD.show()
        let pickUpService = PickUpService()
        pickUpService.getListPersonPickUp { response in
            if let responseModel = MetaResponse(JSON: response){
                if let data = response["data"] as? [[String : Any]]{
                    var array: [ShuttlePersonModel] = []
                    for item in data {
                        if let obj = ShuttlePersonModel(JSON: item) {
                            array.append(obj)
                        }
                        
                    }
                    self.arrayShuttlePerson = array
                    self.tabelView.reloadData()
                }
              
            } else {
                
            }
            SVProgressHUD.dismiss()
        } failure: { error in
            SVProgressHUD.dismiss()
        }

    }
    
}

extension ShuttlePersonViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrayShuttlePerson.count
        }else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShuttlePersonItemTableViewCell", for: indexPath) as! ShuttlePersonItemTableViewCell
            cell.setData(obj: arrayShuttlePerson[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShuttlePersonNoteSchoolTableViewCell", for: indexPath) as! ShuttlePersonNoteSchoolTableViewCell
            return cell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HandlePush().pusDetailPersonPickUp(objShuttlePerson: arrayShuttlePerson[indexPath.row], root: self)
    }
}

extension ShuttlePersonViewController : CreateShuttlePersonViewControllerDelegate {
    func updateListShuttlePerson(array: [ShuttlePersonModel]) {
        self.arrayShuttlePerson = array
        tabelView.reloadData()
    }
}

extension ShuttlePersonViewController : DetailPersonPickUpViewControllerDelete {
    func deletePersonPickUp(obj: ShuttlePersonModel) {
        for i in 0..<arrayShuttlePerson.count {
            if arrayShuttlePerson[i].id == obj.id {
                arrayShuttlePerson.remove(at: i)
                tabelView.reloadData()
                break
            }
        }
    }
    
    func updateArrayShuttlePerson(array: [ShuttlePersonModel]) {
        self.arrayShuttlePerson = array
        tabelView.reloadData()
    }
}
