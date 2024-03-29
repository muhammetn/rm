//
//  NamingVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class NamingVC: UIViewController {
    
    let mainView = NamingView()
    var viewModel = NamingVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    var action: VerificationAction = .sign
    
    convenience init(action: VerificationAction) {
        self.init(nibName: nil, bundle: nil)
        self.action = action
    }
    
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
        mainView.nameField.delegate = self
        mainView.confirmBtn.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isEnabled in
            guard let self = self else {
                return
            }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.frame
            }
        }
        
        viewModel.loadWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print(error.customDescription)
            self.loadingView.removeFromSuperview()
            switch error {
            case .noInternet:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.didFinish.bind { [weak self] success in
            guard let self = self else { return }
            self.loadingView.removeFromSuperview()
            if self.action == .sign && success {
                let vc = CarSelectionVC()
                self.show(vc, sender: self)
            } else if success {
                guard let vc = Helper.getAlert(SuccessVC()) as? SuccessVC else { return }
                vc.mainView.titleLb.text = "Ваша имя успешно изменен".localized()
                vc.mainView.descLb.text = ""
                self.present(vc, animated: true) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    @objc func adjuctForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            mainView.scrollView.contentInset = UIEdgeInsets.zero
        } else {
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
        }
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
    }
    
    @objc func clickConfirm() {
        if (mainView.nameField.text?.count ?? 0) < 4 {
            presentErrorAlert(title: "warning".localized(), msg: "please enter more symbols".localized())
            return
        }
        viewModel.setUsername(username: mainView.nameField.text ?? "")
    }
    
}


extension NamingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
