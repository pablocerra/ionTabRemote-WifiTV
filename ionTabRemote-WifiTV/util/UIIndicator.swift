//
//  UIIndicator.swift
//  ionTabRemote-WifiTV
//
//  Created by pablo Gutierrez on 16/7/21.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    
    func showSpiner(onView: UIView){

        
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
        
        
    }
    
    func removeSpinner() {
           DispatchQueue.main.async {
               vSpinner?.removeFromSuperview()
               vSpinner = nil
           }
    }
    
}
