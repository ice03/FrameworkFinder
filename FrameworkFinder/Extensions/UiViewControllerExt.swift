//
//  UiViewControllerExt.swift
//  FrameworkFinder
//
//  Created by Admin on 17.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    // MARK: Show info in Safari browser
    func presentSafariVC(url: String) {
        guard let readmeUrl = URL(string: url + readmeSegment) else { return }
        let safariVC = SFSafariViewController(url: readmeUrl)
        present(safariVC, animated: true, completion: nil)
    }
    
    // MARK: Show alert
    func showAlert(withTitle title: String, message msg: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
