//
//  VerificationVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit
import OTPFieldView

class VerificationVC: UIViewController {
    
    var phone = String()
    var code = String()
    let mainView = VerificationView()
    var viewModel = VerificationVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(phone: String) {
        self.init(nibName: nil, bundle: nil)
        self.phone = phone
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        navigationItem.backButtonTitle = ""
        hideKeyboardWhenTappedAround()
        let font = [ NSAttributedString.Key.font: UIFont(font: .B1Medium), NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor ]
        let attributed = NSMutableAttributedString(string: "+993 65 124225 belgili nomere ugradyldy", attributes: font)
        let phoneRange = NSRange(location: 0, length: 14)
        attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainColor, range: phoneRange)
        mainView.phoneLb.attributedText = attributed
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        mainView.otpField.delegate = self
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
            case .networkError:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.didSign.bind { [weak self] user in
            guard let self = self, let user = user else {
                return
            }
            AuthHelper.shared.token = user.token
            AuthHelper.shared.username = user.username
            AuthHelper.shared.userId = user.user_id
            self.loadingView.removeFromSuperview()
            AuthHelper.shared.auth = true
            if (user.username ?? "") == "" {
                let vc = NamingVC()
                self.show(vc, sender: self)
            } else {
                let vc = CarSelectionVC()
                self.show(vc, sender: self)
            }
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
        viewModel.signUser(phone: phone, code: code)
//        let vc = NamingVC()
//        show(vc, sender: self)
    }
    
}


extension VerificationVC: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        code = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        mainView.confirmBtn.isEnabled = hasEnteredAll ? true : false
        mainView.confirmBtn.backgroundColor = hasEnteredAll ? .mainColor : .passiveTextColor
        return hasEnteredAll
    }
    
    
}
