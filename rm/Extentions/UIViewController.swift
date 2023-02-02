//
//  UIViewController.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentErrorAlert(title: String = "Error".localized(), msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok".localized(), style: .default)
        alert.addAction(okAction)
        let generator = UINotificationFeedbackGenerator()
        present(alert, animated: true) {
            generator.notificationOccurred(.error)
        }
    }
    
}
