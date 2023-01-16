//
//  VerificationVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class VerificationVC: UIViewController {
    
    let mainView = VerificationView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        hideKeyboardWhenTappedAround()
        let font = [ NSAttributedString.Key.font: UIFont(font: .B1Medium), NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor ]
        let attributed = NSMutableAttributedString(string: "+993 65 124225 belgili nomere ugradyldy", attributes: font)
        let phoneRange = NSRange(location: 0, length: 14)
        attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainColor, range: phoneRange)
        mainView.phoneLb.attributedText = attributed
        
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
        let vc = NamingVC()
        show(vc, sender: self)
    }
    
}
