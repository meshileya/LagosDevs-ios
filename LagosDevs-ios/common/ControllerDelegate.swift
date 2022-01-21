//
//  ControllerDelegate.swift
//  LagosDevs-ios
//
//  Created by tech on 21/01/2022.
//

import Foundation
import UIKit

protocol ControllerDelegate {
    
    func showProgress(_ text: String)
    func hideProgress()
}

extension ControllerDelegate where Self:UIViewController {
    
    func showProgress (_ text: String = "") {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        indicator.tag = 90101
        indicator.center = view.center
        indicator.color = .black
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func hideProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let coverView = self.view.viewWithTag(90101) as? UIActivityIndicatorView {
            coverView.stopAnimating()
            coverView.removeFromSuperview()
        }
    }
}
