//
//  AddCommentVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit

class AddReviewVC: UIViewController {
    
    let mainView = AddReviewView()
    var viewModel: AddReviewVM?
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    convenience init(orderId: Int) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = AddReviewVM(orderId: orderId)
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
        hideKeyboardWhenTappedAround()
        mainView.textView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjuctForKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        mainView.ratingView.didFinishTouchingCosmos = { rating in
            self.viewModel?.rating = Int(rating)
        }
        mainView.closeBtn.addTarget(self, action: #selector(didTappedCloseBtn), for: .touchUpInside)
        mainView.confirmCallback = { [weak self] in
            self?.didTappedAdd()
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        viewModel.isLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        
        viewModel.didLoadWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print("error \(error.customDescription)")
            self.loadingView.removeFromSuperview()
            switch error {
            case .noInternet:
                self.networkErrorView.isHidden = false
                self.view = self.networkErrorView
                return
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.didLoad.bind { [weak self] loaded in
            guard let self = self else { return }
            if !loaded { return }
            self.view = self.mainView
            self.loadingView.removeFromSuperview()
            self.dismiss(animated: true)
        }
    }
    
    func didTappedAdd() {
        viewModel?.review = mainView.textView.text
        if (viewModel?.review ?? "") == "Ваш отзыв".localized() {viewModel?.review = ""}
        viewModel?.addReview()
        
    }
    
    @objc func didTappedCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func adjuctForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            mainView.scrollView.contentInset = UIEdgeInsets.zero
        }else{
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndFrame.height, right: 0)
        }
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
        mainView.scrollView.setContentOffset(CGPoint(x: mainView.scrollView.contentOffset.x, y: 0), animated: true)
    }
    
}

extension AddReviewVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .passiveTextColor {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Ваш отзыв".localized()
            textView.textColor = .passiveTextColor
        }
    }
    
}
