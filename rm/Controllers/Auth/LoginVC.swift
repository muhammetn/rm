//
//  LoginVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class LoginVC: UIViewController {
    
    let mainView = LoginView()
    var viewModel = LoginVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//        mainView.phoneField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        mainView.phoneField.delegate = self
        mainView.confirmBtn.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        viewModel.loadWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print(error.customDescription)
            self.loadingView.removeFromSuperview()
            switch error {
            case .networkError:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
            
        }
        
        viewModel.didStartVerification.bind { [weak self] phone in
            guard let self = self, let phone = phone else {
                return
            }
            self.loadingView.removeFromSuperview()
            let vc = VerificationVC(phone: phone)
            self.show(vc, sender: self)
//            print("success: \(success)")
        }
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
        viewModel.startVer(phone: mainView.phoneField.text ?? "")
//        let vc = VerificationVC()
//        show(vc, sender: self)
    }
    
//    @objc private func textFieldDidChange(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        print(text)
//    }
    
}


extension LoginVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = Helper.format(with: "XX XX XX XX", phone: newString)
        if textField.text?.count == 11 {
            mainView.confirmBtn.backgroundColor = .mainColor
            mainView.confirmBtn.isEnabled = true
        } else {
            mainView.confirmBtn.backgroundColor = .passiveTextColor
            mainView.confirmBtn.isEnabled = false
        }
        return false
    }
    
}
