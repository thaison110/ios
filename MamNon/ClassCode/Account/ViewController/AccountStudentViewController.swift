//
//  AccountStudentViewController.swift
//  MamNon
//
//  Created by Ngo Thuy on 18/09/2022.
//

import UIKit

class AccountStudentViewController: UIViewController {

    var isEdit  = false
    @IBOutlet weak var tabelView: UITableView!
    var imageAvatarUpdate : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabelView.dataSource = self
        self.tabelView.delegate = self
        // Do any additional setup after loading the view.
        tabelView.register(UINib(nibName: "AccountStudentTableViewCell", bundle: nil), forCellReuseIdentifier: "AccountStudentTableViewCell")
        tabelView.register(UINib(nibName: "EditAccountStudentTableViewCell", bundle: nil), forCellReuseIdentifier: "EditAccountStudentTableViewCell")
        
    }
    
    


    

}

extension AccountStudentViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEdit {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditAccountStudentTableViewCell", for: indexPath) as! EditAccountStudentTableViewCell
            cell.root = self
            if let image =  imageAvatarUpdate {
                cell.setUpdateImage(image: image)
            }
            cell.updateAccountSuccess = { isSuccess in
                self.isEdit = false
                self.tabelView.reloadData()
                if isSuccess {
                    self.showToast(message: "Thông tin đã được cập nhật!")
                }
            }
           
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountStudentTableViewCell", for: indexPath) as! AccountStudentTableViewCell
            cell.actionEidtAccount = {
                self.isEdit = true
                self.tabelView.reloadData()
            }
            cell.setData()
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AccountStudentViewController : ContainerChoiceImaeFloatingViewControllerDelegate {
    func choiceListImage(listImage: [ImageLibraryModel]) {
        if listImage.count > 0 {
            let image =  listImage[0]
            image.getImageFormAsset()
            imageAvatarUpdate = image.image
            tabelView.reloadData()
        }
    }
    
    
}

