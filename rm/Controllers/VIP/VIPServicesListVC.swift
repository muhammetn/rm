//
//  VIPServicesVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class VIPServicesListVC: UIViewController {
    
    let mainView = VIPServicesListView()
    var viewModel = VIPServicesListVM()
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
        title = "VIP услуги"
        navigationItem.largeTitleDisplayMode = .always
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        networkErrorView.callBack = { [weak self] in
            guard let self = self else { return }
            self.networkErrorView.isHidden = true
            self.view.addSubview(self.loadingView)
            self.loadingView.frame = self.view.bounds
            self.viewModel.getServices()
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
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.services.bind { [weak self] cars in
            guard let self = self else { return }
            self.view = self.mainView
            self.loadingView.removeFromSuperview()
            self.mainView.tableView.reloadData()
        }
        viewModel.getServices()
    }
    
}

extension VIPServicesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VIPPackageServiceVC(service: viewModel.services.value[indexPath.row])
        show(vc, sender: self)
    }
    
}

extension VIPServicesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.services.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VIPServicesListCell.identifier, for: indexPath) as! VIPServicesListCell
        cell.initData(viewModel.services.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
