//
//  ServicesVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class StatusVC: UIViewController {
    
    var page: Int = 1
    let mainView = StatusView()
    var viewModel: StatusVM?
    lazy var loadingView = LoadingView()
    lazy var noOrderView = NoOrderView()
    
    override func loadView() {
        viewModel = StatusVM()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.orders.removeAll()
        viewModel?.doneOrders.removeAll()
        viewModel?.onProcess.removeAll()
        mainView.tableView.reloadData()
        viewModel?.load = true
        page = 1
        viewModel?.getOrders(page: self.page)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        title = "Статусы".localized()
        navigationItem.backButtonTitle = ""
        navigationItem.largeTitleDisplayMode = .always
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        noOrderView.startCallback = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
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
        
        viewModel.didFinishWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print("error \(error.customDescription)")
            self.loadingView.removeFromSuperview()
            self.presentErrorAlert(msg: error.customDescription)
        }
        
        viewModel.didFinish.bind { [weak self] orders in
            guard let self = self, let orders = orders else { return }
            self.loadingView.removeFromSuperview()
            if self.page == 1 && orders.count == 0 {
                self.view = self.noOrderView
                self.noOrderView.frame = self.view.bounds
                return
            }
            self.view = self.mainView
            orders.forEach({
                guard let viewModel = self.viewModel  else { return }
                let cnt1 = viewModel.onProcess.count
                let cnt2 = viewModel.doneOrders.count
                if ($0.status ?? "") == "completed" || ($0.status ?? "") == "canceled" {
                    viewModel.doneOrders.append($0)
                } else {
                    viewModel.onProcess.append($0)
                }
                if self.page == 1 {
                    self.mainView.tableView.reloadData()
                } else {
                    let indexPaths1 = (cnt1 ..< viewModel.onProcess.count).map { IndexPath(row: $0, section: 0) }
                    let indexPaths2 = (cnt2 ..< viewModel.doneOrders.count).map { IndexPath(row: $0, section: 1) }
                    self.mainView.tableView.beginUpdates()
                    self.mainView.tableView.insertRows(at: indexPaths1, with: .fade)
                    self.mainView.tableView.insertRows(at: indexPaths2, with: .fade)
                    self.mainView.tableView.endUpdates()
                }
            })
        }
    }
    
}


extension StatusVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let orderId = viewModel?.onProcess[indexPath.row].order_id else { return }
            let vc = StatusDetailVC(orderId)
            show(vc, sender: self)
        } else {
            guard let orderId = viewModel?.doneOrders[indexPath.row].order_id else { return }
            let vc = StatusDetailVC(orderId)
            show(vc, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeader.identifier) as! TitleHeader
        header.titleLeading.isActive = false
        header.titleCenterY.isActive = true
        header.titleCenterY.constant = 0
        header.titleLb.text = section == 0 ? "Активны".localized() : "Выполнены".localized()
        return header
    }

}

extension StatusVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return section == 0 ? viewModel.onProcess.count : viewModel.doneOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCell.identifier, for: indexPath) as! StatusCell
        guard let viewModel = viewModel else { return cell }
        switch indexPath.section {
        case 0:
            cell.initDate(viewModel.onProcess[indexPath.row])
        default:
            cell.initDate(viewModel.doneOrders[indexPath.row])
        }
        if indexPath.row == viewModel.orders.count - 1 {
            page += 1
            viewModel.getOrders(page: page)
        }
        return cell
    }
    
    
}
