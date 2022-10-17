//
//  BoardHomeTableViewCell.swift
//  MamNon
//
//  Created by Thắng Trương on 17/09/2022.
//

import UIKit

class BoardHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var table: UITableView!
    var activate : [ActivateModel]?
    @IBOutlet weak var icArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorColor = .clear
        self.table.register(UINib (nibName: "ItemBoardHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemBoardHomeTableViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data : [ActivateModel]?) {
        self.activate = data
        self.table.reloadData()
        
    }
    
}

extension BoardHomeTableViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activate?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemBoardHomeTableViewCell", for: indexPath) as! ItemBoardHomeTableViewCell
        let obj = self.activate?[indexPath.row]
        cell.configCell(data: obj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
