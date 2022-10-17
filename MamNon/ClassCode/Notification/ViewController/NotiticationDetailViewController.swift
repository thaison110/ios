//
//  NotiticationDetailViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 20/09/2022.
//

import UIKit
protocol NotiticationDetailViewControllerDelegate{
    func closeView()
}
class NotiticationDetailViewController: UIViewController {
    

    @IBOutlet weak var tabelView: UITableView!
    var delegate : NotiticationDetailViewControllerDelegate?
    var objNotifi: NotificationModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.register(UINib(nibName: "NotificationDetailTextTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationDetailTextTableViewCell")
        // Do any additional setup after loading the view.
    }


    @IBAction func pressedClose(_ sender: Any) {
        if let delegate = self.delegate{
            delegate.closeView()
        }
    }
    

}

extension NotiticationDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationDetailTextTableViewCell", for: indexPath) as! NotificationDetailTextTableViewCell
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
   
}
