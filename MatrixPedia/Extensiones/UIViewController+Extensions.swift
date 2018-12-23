//
//  UIViewController+Extensions.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

typealias AlertCompletionHandler = () -> Void

extension UIViewController {
    func alertController(title: String? = nil, message: String?) -> UIAlertController? {
        guard view.window != nil else {
            return nil
        }
        
        guard let message = message else {
            return nil
        }
        
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func showAlert(title: String? = nil, message: String?, completion: AlertCompletionHandler? = nil) {
        guard let alert = alertController(title: title, message: message) else {
            completion?()
            return
        }
        
        let accept = agreedAction(alert) {
            completion?()
        }
        
        alert.addAction(accept)
        
        presentAlert(alert)
    }
    
    func showErrorAlert(message: String?, completion: AlertCompletionHandler? = nil) {
        showAlert(title: "Error", message: message, completion: completion)
    }
    
    func agreedAction(_ alert: UIAlertController, completionHandler: (() -> Void)?) -> UIAlertAction {
        return dismissAction(title: "OK", style: .default, alert: alert, completionHandler: completionHandler)
    }
    
    func dismissAction(title: String, style: UIAlertAction.Style, alert: UIAlertController, completionHandler: (() -> Void)?) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: { [weak alert] (_) -> Void in
            completionHandler?()
            alert?.dismiss(animated: true, completion: nil)
        })
        
        return action
    }
    
    func presentAlert(_ alert: UIAlertController) {
        if let currentViewController = UIApplication.serviceLocator.mainRouter.currentViewController {
            currentViewController.present(alert, animated: true, completion: nil)
        }
    }
}
