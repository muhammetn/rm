//
//  HomeVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    let mainView = HomeView()
    var viewModel = HomeVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let path = Bundle.main.path(forResource: "tk", ofType: "lproj")
        AppLanguage.setAppleLanguageTo(lang: "ru")
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .backgroundColor
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        networkErrorView.callBack = { [weak self] in
            guard let self = self else { return }
            self.networkErrorView.isHidden = true
            self.view.addSubview(self.loadingView)
            self.loadingView.frame = self.view.bounds
            self.viewModel.getWashers()
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
        
        viewModel.didFinishWithError.bind { [weak self] error in
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
        
        viewModel.washers.bind { [weak self] washers in
            guard let self = self else { return }
            self.view = self.mainView
            self.loadingView.removeFromSuperview()
            self.mainView.tableView.reloadData()
        }
        viewModel.getWashers()
    }
    
}

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeader.identifier) as! TitleHeader
        switch section {
        case 0:
            header.titleLb.text = "Тип машины:".localized()
        case 1:
            header.titleLb.text = "VIP услуги".localized()
        default:
            header.titleLb.text = "Выберите мойщики"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            clickChangeCar()
        case 1:
            let vc = VIPServicesListVC()
            show(vc, sender: self)
        default:
            let vc = ServicesDetailVC(washer: viewModel.washers.value[indexPath.row])
            show(vc, sender: self)
        }
    }
    
    func clickChangeCar() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let vc = CarSelectionVC()
        window.rootViewController = vc
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {
        }, completion: { completed in })
    }
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if #available(iOS 15.0, *) {
            return 40
        } else {
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 52 * KeyWords.widthRatio + 30
        case 1:
            return 62 * KeyWords.widthRatio
        default:
            return 104 * KeyWords.widthRatio + 10
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return viewModel.washers.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditeCarCell.identifier, for: indexPath) as! EditeCarCell
            cell.selectionStyle = .none
            cell.backgroundColor = .backgroundColor
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: VIPServiceCell.identifier, for: indexPath) as! VIPServiceCell
            cell.selectionStyle = .none
            cell.backgroundColor = .backgroundColor
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: WasherCell.identifier, for: indexPath) as! WasherCell
            cell.selectionStyle = .none
            cell.initData(viewModel.washers.value[indexPath.row])
            cell.backgroundColor = .backgroundColor
            return cell
        }
    }
    
    
}
