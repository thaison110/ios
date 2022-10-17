//
//  HeaderView.swift
//  MamNon
//
//  Created by Ngo Thuy on 16/09/2022.
//

import UIKit

class HeaderView: UIView {

    override func awakeFromNib() {
        
    }
    
    
    func setupUI(rootView: UIView? = nil){
      
        if let root = rootView{
            self.frame = CGRect(x: 0, y: 0, width: root.bounds.width, height: root.bounds.height)
        }
        
        
    }

}
