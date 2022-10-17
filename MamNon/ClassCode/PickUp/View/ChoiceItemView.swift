//
//  ChoiceItemView.swift
//  MamNon
//
//  Created by Lê Đình Đạt on 21/09/2022.
//

import UIKit

protocol ChoiceItemViewDelegate {
    func choiceItem(indexChoice: Int, text: String)
}

class ChoiceItemView: UIView {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var tabelView: UITableView!
    var delegate : ChoiceItemViewDelegate?
    var arrayItem : [String] = []
    var indexChoice = 0
    override func awakeFromNib() {
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        self.tabelView.register(UINib(nibName: "ChoiceViewItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceViewItemTableViewCell")
        setShadow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.tabelView.scrollToRow(at: IndexPath(row: self.indexChoice, section: 0), at: .top, animated: false)
        }
        
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
}

extension ChoiceItemView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceViewItemTableViewCell", for: indexPath) as! ChoiceViewItemTableViewCell
        if indexPath.row == indexChoice {
            cell.imageTick.isHidden = false
            cell.labelTitle.textColor = UIColor.init(hexString: "#005CC8")
        }else{
            cell.imageTick.isHidden = true
            cell.labelTitle.textColor = UIColor.black
        }
        cell.labelTitle.text = arrayItem[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            delegate.choiceItem(indexChoice: indexPath.row, text: arrayItem[indexPath.row])
        }
    }
}
