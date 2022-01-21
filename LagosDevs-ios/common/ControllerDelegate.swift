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
    func showAlert(title: String, message : String?, actionTitle: String?, action: ((UIAlertAction) -> Void)?)
    func showAlertWithTwoOptions(title: String, message : String?, firstActionLabel : String, firstAction : ((UIAlertAction) -> Void)?, secondActionLabel : String,  secondAction: ((UIAlertAction) -> Void)?)
    
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
    
    func showAlert(title: String, message : String?, actionTitle: String? = "Ok", action : ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        
        let alertAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: action)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTwoOptions(title: String, message : String?, firstActionLabel : String = "Continue", firstAction okA : ((UIAlertAction) -> Void)?, secondActionLabel : String = "Cancel", secondAction cancelA : ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        
        let alertAction = UIAlertAction(title: firstActionLabel, style: UIAlertAction.Style.default, handler: okA)
        let cancelAction = UIAlertAction(title: secondActionLabel, style: UIAlertAction.Style.default, handler: cancelA)
        
        alert.addAction(alertAction);
        alert.addAction(cancelAction);
        self.present(alert, animated: true, completion: nil)
    }
}
