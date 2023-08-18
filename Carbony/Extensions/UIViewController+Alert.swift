//
//  UIViewController+Alert.swift
//  Carbony
//
//  Created by doss-zstch1212 on 11/08/23.
//

import Foundation
import UIKit

extension UIViewController {
    /// This method is for show the alert and dismissing the pop-up controller.
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
