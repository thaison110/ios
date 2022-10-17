//
//  ChoiceTimePickUpView.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 21/09/2022.
//

import UIKit
protocol ChoiceTimePickUpViewDelegate {
    func choiceIndexTime(index: Int)
}


class ChoiceTimePickUpView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tabelView: UITableView!
    var delegate : ChoiceTimePickUpViewDelegate?
    override func awakeFromNib() {
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.register(UINib(nibName: "ChoiceTimePickUpViewItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceTimePickUpViewItemTableViewCell")
        setShadow()
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
        viewContent.layer.shadowOpacity = 0.6
        viewContent.layer.shadowRadius = 4.0
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceTimePickUpViewItemTableViewCell", for: indexPath) as! ChoiceTimePickUpViewItemTableViewCell
        if indexPath.row == 0 {
            cell.imageTime.image = UIImage(named: "ic_PickUpOnTime")
            cell.labelTime.text = "Đón đúng giờ"
            cell.labelTime.textColor = UIColor.init(hexString: "#27AE60")
            cell.viewLine.isHidden = false
            cell.imageArrow.isHidden = false
        }else if indexPath.row == 1 {
            cell.imageTime.image = UIImage(named: "ic_PickUpEarly")
            cell.labelTime.text = "Đón sớm"
            cell.labelTime.textColor = UIColor.init(hexString: "#FF7917")
            cell.viewLine.isHidden = false
            cell.imageArrow.isHidden = true
        }else{
            cell.imageTime.image = UIImage(named: "ic_PickUpLate")
            cell.labelTime.text = "Đón muộn"
            cell.labelTime.textColor = UIColor.init(hexString: "#FF5959")
            cell.viewLine.isHidden = true
            cell.imageArrow.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.choiceIndexTime(index: indexPath.row)
        }
    }
    

}
