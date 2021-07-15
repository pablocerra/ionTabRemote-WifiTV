//
//  UIButtonExtension.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 15/7/21.
//

import UIKit

private let orange = UIColor(red: 254/255, green: 148/255, blue: 0/255, alpha: 1)

extension UIButton {
    
    
    func round() {

        clipsToBounds = true
       
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        layer.cornerRadius = bounds.height / 2
        
    }
    
    func roundUPButton() {
        
        let maskPath1 = UIBezierPath(roundedRect: bounds,
        byRoundingCorners: [.topLeft , .topRight],
        cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    
    }
    
    func roundDowButton() {
        
        let maskPath1 = UIBezierPath(roundedRect: bounds,
        byRoundingCorners: [.bottomLeft , .bottomRight],
        cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    
    }
    

}
