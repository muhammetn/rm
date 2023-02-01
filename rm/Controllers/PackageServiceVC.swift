//
//  PackageServiceVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

enum WashTime {
    case select
    case now
}

class PackageServiceVC: UIViewController {
    
//    MARK: -Properties
    var service = ServicePackage()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    let mainView = PackageServiceView()
    var viewModel: PackageServiceVM?
    
    
//    MARK: -init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(service: ServicePackage, washer: Washer) {
        self.init(nibName: nil, bundle: nil)
        self.service = service
        self.viewModel = PackageServiceVM(package: service, washer: washer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: -Life cycles
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
//    MARK: -Helper funcs
    private func setupUI() {
        title = service.getTitle()
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboardWhenTappedAround()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        hideKeyboardWhenTappedAround()
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
    
//    MARK: -Actions
    @objc func clickFooter() {
        guard let viewModel = viewModel else { return }
        if viewModel.carModel.count < 3 {
            presentErrorAlert(title: "warning", msg: "please enter car model!")
            return
        }
        if viewModel.carNo.count < 1 {
            presentErrorAlert(title: "warning", msg: "please enter car no!")
            return
        }
        if viewModel.timeSelection == .now {
            viewModel.createOrder()
        } else {
            let vc = DatePickerVC(package: viewModel.package, carNo: viewModel.carNo, carType: viewModel.carModel)
            show(vc, sender: self)
        }
    }
    
    @objc func carModelTextFieldDidChange(_ textField: UITextField) {
        viewModel?.carModel = textField.text ?? ""
    }
    
    @objc func carNoTextFieldDidChange(_ textField: UITextField) {
        viewModel?.carNo = textField.text ?? ""
    }
    
    func clickSelection(type: WashTime) {
        viewModel?.timeSelection = type
    }
}

//    MARK: -UITableView's Delegate & DateSource
extension PackageServiceVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 * KeyWords.widthRatio + 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PackageServiceInfoCell.identifier, for: indexPath) as! PackageServiceInfoCell
            cell.icon1Img.image = UIImage(named: "user")
            cell.title1Lb.text = "Минимум 1 мойщик"
            cell.selectionStyle = .none
            cell.activateIconBottom()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FormsCell.identifier, for: indexPath) as! FormsCell
            cell.carModelField.addTarget(self, action: #selector(carModelTextFieldDidChange), for: .allEditingEvents)
            cell.carNumberField.addTarget(self, action: #selector(carNoTextFieldDidChange), for: .allEditingEvents)
            cell.carNumberField.delegate = self
            cell.carModelField.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCheckCell.identifier, for: indexPath) as! TimeCheckCell
            cell.nowDateCallback = { [weak self] in
                guard let self = self else { return }
                self.clickSelection(type: .now)
            }
            cell.selectionDateCallback = { [weak self] in
                guard let self = self else { return }
                self.clickSelection(type: .select)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
        footer.calculate(service: service)
        footer.clickCallback = { [weak self] in
            guard let self = self else {
                return
            }
            self.clickFooter()
        }
        return footer
    }
}

//  MARK: -TextField extentions
extension PackageServiceVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
