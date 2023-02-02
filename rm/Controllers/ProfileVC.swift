//
//  ProfileVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    let mainView = ProfileView()
    var viewModel = ProfileVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "Профил и настройки".localized()
        navigationItem.largeTitleDisplayMode = .always
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationItem.backButtonTitle = ""
        
        mainView.nameCallback = { [weak self] in
            guard let self = self else { return }
            let vc = NamingVC(action: .changePhone)
            self.show(vc, sender: self)
        }
        
        mainView.phoneCallback = { [weak self] in
            guard let self = self else { return }
            let vc = ChangePhoneVC()
            self.show(vc, sender: self)
        }
        mainView.removeAccountCallback = { [weak self] in
            guard let self = self else { return }
            self.clickRemoveAccount()
        }
        mainView.logOutCallback = { [weak self] in
            guard let self = self else { return }
            self.clickLogout()
        }
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        
        viewModel.loadedWithError.bind { [weak self] error in
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
        
        viewModel.loaded.bind { [weak self] user in
            guard let self = self else { return }
            self.view = self.mainView
            self.loadingView.removeFromSuperview()
            self.mainView.usernameLb.text = user?.username
            self.mainView.phoneLb.text = "\(Helper.format(with: "+XXX XX XX XX XX", phone: "\(user?.phone ?? "")"))"
        }
        viewModel.loadUser()
    }
    
    func clickRemoveAccount() {
        let alert = UIAlertController(title: "warning".localized(), message: "do you want remove your account?".localized(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "yes".localized(), style: .destructive) { _ in
            AuthHelper.shared.token = nil
            AuthHelper.shared.auth = false
            AuthHelper.shared.username = nil
            AuthHelper.shared.userId = nil
            let vc = UINavigationController(rootViewController: LoginVC())
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
        let cancel = UIAlertAction(title: "cancel".localized(), style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func clickLogout() {
        let alert = UIAlertController(title: "warning".localized(), message: "do you want log out?".localized(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "yes".localized(), style: .destructive) { _ in
            AuthHelper.shared.token = nil
            AuthHelper.shared.auth = false
            AuthHelper.shared.username = nil
            AuthHelper.shared.userId = nil
            let vc = UINavigationController(rootViewController: LoginVC())
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
        let cancel = UIAlertAction(title: "cancel".localized(), style: .default)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
