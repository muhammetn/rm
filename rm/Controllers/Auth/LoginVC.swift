//
//  LoginVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class LoginVC: UIViewController {
    
    let mainView = LoginView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        mainView.confirmBtn.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    @objc func adjuctForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            mainView.scrollView.contentInset = UIEdgeInsets.zero
        }else{
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
        }
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
    }
    
    @objc func clickConfirm() {
        let vc = VerificationVC()
        show(vc, sender: self)
    }
    
    
}
