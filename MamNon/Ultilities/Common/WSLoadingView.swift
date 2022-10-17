//
//  WSLoadingView.swift
//  KingHub
//
//  Created by Dinh  Dai on 7/8/19.
//  Copyright © 2019 VivaVietNam. All rights reserved.
//

import UIKit

class WSLoadingView {
    
    class func show() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let containerView = UIView(frame: CGRect(x: SCREEN_WIDTH/2 - 50, y: SCREEN_HEIGHT/2 - 50, width: 100, height: 100))
        containerView.backgroundColor = .clear
        containerView.tag = 2125
        window.addSubview(containerView)
        let indicator = UIActivityIndicatorView()
        indicator.tag = 2521
        indicator.center = CGPoint(x: containerView.bounds.size.width/2, y: containerView.bounds.size.height/2)
        indicator.style = .gray
        containerView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    class func hide() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        if let viewWithTag = window.viewWithTag(2521) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = window.viewWithTag(2125) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    class func showWithMask() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        containerView.backgroundColor = .black
        containerView.alpha = 0.2
        containerView.tag = 2125
        window.addSubview(containerView)
        let indicator = UIActivityIndicatorView()
        indicator.tag = 2521
        indicator.center = CGPoint(x: containerView.bounds.size.width/2, y: containerView.bounds.size.height/2)
        indicator.style = .white
        containerView.addSubview(indicator)
        indicator.startAnimating()
    }
}
