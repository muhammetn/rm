//
//  SelectedServicesListVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class SelectedServicesListVC: UIViewController {
    
    let mainView = SelectedServicesListView()
    var viewModel: SelectedServicesListVM?
    
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    init(services: [Service], washer: Washer) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = SelectedServicesListVM(services: services, washer: washer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        title = "Выбранные услуги (\(viewModel?.services.count ?? 0) услуги)"
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel?.didStartLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        
        viewModel?.didFinishWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print("error \(error.customDescription)")
            self.loadingView.removeFromSuperview()
            switch error {
            case .noInternet:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        viewModel?.didFinish.bind({ [weak self] value in
            guard let self = self else { return }
            if value {
                print("success")
                self.loadingView.removeFromSuperview()
                let vc = Helper.getAlert(SuccessVC())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.present(vc, animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
    }
    
    @objc func clickRemove(index: Int) {
        guard let vc = Helper.getAlert(RemoveAlertVC(index: index)) as? RemoveAlertVC else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func clickSelection(type: WashTime) {
        viewModel?.timeSelection = type
    }
    
    func clickOrder() {
        guard let viewModel = viewModel else {
            return
        }
        if viewModel.carNo == "" {
            presentErrorAlert(title: "warning", msg: "please enter car no!")
            return
        }
        if viewModel.carModel == "" {
            presentErrorAlert(title: "warning", msg: "please enter car no!")
            return
        }
        if viewModel.timeSelection == .now {
            viewModel.createOrder()
        } else {
            let vc = DatePickerVC(services: viewModel.services, carNo: viewModel.carNo, carType: viewModel.carModel)
            self.show(vc, sender: self)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1 {
            viewModel?.carModel = textField.text ?? ""
        } else {
            viewModel?.carNo = textField.text ?? ""
        }
    }
}

extension SelectedServicesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 * KeyWords.widthRatio + 40
    }
    
}

extension SelectedServicesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        switch indexPath.row {
        case viewModel.rowCount - 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormsCell.identifier, for: indexPath) as! FormsCell
            cell.carNumberField.delegate = self
            cell.carModelField.delegate = self
            cell.selectionStyle = .none
            cell.carNumberField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
            cell.carModelField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
            return cell
        case viewModel.rowCount - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCheckCell.identifier, for: indexPath) as! TimeCheckCell
            cell.selectionDateCallback = { [weak self] in
                self?.clickSelection(type: .select)
            }
            cell.nowDateCallback = { [weak self] in
                self?.clickSelection(type: .now)
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectedServicesCell.identifier, for: indexPath) as! SelectedServicesCell
            cell.initData(service: viewModel.services[indexPath.row])
            cell.removeCallback = { [weak self] in
                self?.clickRemove(index: indexPath.row)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil}
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
        footer.calculate(viewModel.services)
        footer.clickCallback = { [weak self] in
            guard let self = self else {
                return
            }
            self.clickOrder()
        }
        return footer
    }
    
}


extension SelectedServicesListVC: RemoveDelegate {
    func remove(index: Int) {
        viewModel?.services.remove(at: index)
        viewModel?.rowCount -= 1
        mainView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        mainView.tableView.reloadData()
        if viewModel?.services.count == 0 {
            navigationController?.popViewController(animated: true)
        }
        title = "Выбранные услуги (\(viewModel?.services.count ?? 0) услуги)"
    }
}

extension SelectedServicesListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
