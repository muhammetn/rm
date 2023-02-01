//
//  VIPPackageServiceVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class VIPPackageServiceVC: UIViewController {
    
    var carModel = String()
    var carNumber = String()
    
    let mainView = VIPPackageServiceView()
    var viewModel: VIPPackageServiceVM?
    
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(service: Service) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = VIPPackageServiceVM(service: service)
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
        title = "Полная мойка (кузов, салон)"
        extendedLayoutIncludesOpaqueBars = true
        hideKeyboardWhenTappedAround()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
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
                }
            }
        })
    }
    
    @objc func clickFooter() {
        if carModel == "" {
            presentErrorAlert(title: "warning", msg: "please enter car model!")
            return
        }
        if carNumber == "" {
            presentErrorAlert(title: "warning", msg: "please enter car number!")
            return
        }
        viewModel?.createOrder(carNo: carNumber, carType: carModel)
    }
    
    @objc func carModelFieldDidChange(_ textField: UITextField) {
        carModel = textField.text ?? ""
    }
    
    @objc func carNumberFieldDidChange(_ textField: UITextField) {
        carNumber = textField.text ?? ""
    }
    
}

extension VIPPackageServiceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 * KeyWords.widthRatio + 10
    }
    
}

extension VIPPackageServiceVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PackageServiceInfoCell.identifier, for: indexPath) as! PackageServiceInfoCell
            cell.activateStrokeBottom()
            cell.title1Lb.text = "\(viewModel?.service.duration ?? 0) минут"
            cell.title2Lb.text = "Минимум \(viewModel?.service.min_washer ?? 0) мойщик"
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormsCell.identifier, for: indexPath) as! FormsCell
            cell.carModelField.addTarget(self, action: #selector(carModelFieldDidChange), for: .allEditingEvents)
            cell.carNumberField.addTarget(self, action: #selector(carNumberFieldDidChange), for: .allEditingEvents)
            cell.carModelField.delegate = self
            cell.carNumberField.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
        guard let service = viewModel?.service else { return nil }
        footer.calculate([service])
        footer.clickCallback = { [weak self] in
            guard let self = self else {
                return
            }
            self.clickFooter()
        }
        return footer
    }
    
}


extension VIPPackageServiceVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
