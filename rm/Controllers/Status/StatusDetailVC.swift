//
//  StatusDetailVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class StatusDetailVC: UIViewController {
    
    let mainView = StatusDetailView()
    var viewModel: StatusDetailVM?
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    convenience init(_ order_id: Int) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = StatusDetailVM(orderId: order_id)
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "Полная информация".localized()
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
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
        viewModel.didFinish.bind { [weak self] order in
            guard let self = self else { return }
            self.view = self.mainView
            self.loadingView.removeFromSuperview()
            viewModel.orderDetail = order
            self.mainView.tableView.reloadData()
        }
        viewModel.getStatusDetail()
    }
    
    func clickAddReview() {
        guard let orderId = viewModel?.orderId else { return }
        let vc = Helper.getAlert(AddReviewVC(orderId: orderId))
        present(vc, animated: true)
    }
    
}


extension StatusDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = viewModel?.orderDetail else {
            return 0
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let order = viewModel?.orderDetail else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatusDetailCell.identifier, for: indexPath) as! StatusDetailCell
            cell.initData(order: order)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailCell.identifier, for: indexPath) as! CarDetailCell
            cell.initData(order: order)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailCell.identifier, for: indexPath) as! ServiceDetailCell
            cell.order = order
            cell.services = order.services
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100 * KeyWords.widthRatio
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let order = viewModel?.orderDetail else { return nil}
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterReviewView.identifier) as! FooterReviewView
        if (order.status ?? "") == "completed" {
            footer.addReviewView.backgroundColor = .mainColor
            footer.clickCallback = { [weak self] in
                self?.clickAddReview()
            }
        }
        return footer
    }
    
}
