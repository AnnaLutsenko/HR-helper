//
//  UIAlertController+Ext.swift
//  HR-helperApp
//
//  Created by Anna on 8/3/18.
//  Copyright © 2018 Anna. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func presentAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}

