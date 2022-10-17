//
//  UIView+EdgeShadow.swift
//  PullToDismiss
//
//  Created by Suguru Kishimoto on 1/6/17.
//  Copyright © 2017 Suguru Kishimoto. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyEdgeShadow(_ shadow: EdgeShadow?) {
        guard let shadow = shadow else {
            detachEdgeShadow()
            return
        }
        layer.shadowOpacity = shadow.opacity
        layer.shadowRadius = shadow.radius
        layer.shadowOffset = shadow.offset
        layer.shadowColor = shadow.color.cgColor
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
    }
    
    func updateEdgeShadow(_ shadow: EdgeShadow?, rate: CGFloat) {
        guard let shadow = shadow else {
            detachEdgeShadow()
            return
        }
        layer.shadowOpacity = shadow.opacity * Float(rate)
    }
    
    func detachEdgeShadow() {
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.shadowColor = nil
        layer.shadowPath = nil
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
