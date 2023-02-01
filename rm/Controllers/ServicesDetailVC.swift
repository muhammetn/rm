//
//  ServicesDetailVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

enum State {
    case ownService
    case customService
}

class ServicesDetailVC: UIViewController {
    
    var selectedServices = [Service]()
    var state: State = .ownService
    
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    let mainView = ServicesDetailView()
    var viewModel: ServicesDetailVM?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(washer: Washer) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = ServicesDetailVM(washer: washer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {
            return
        }
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
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.didFinish.bind { [weak self] isFinished in
            guard let self = self else { return }
            if isFinished {
                self.loadingView.removeFromSuperview()
                self.mainView.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                print("Finished")
            }
        }
        viewModel.getServices()
    }
    
}


extension ServicesDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if state == .ownService {
            guard let viewModel = viewModel else {
                return
            }
            let vc = PackageServiceVC(service: viewModel.servicePackages.value[indexPath.row], washer: viewModel.washer)
            show(vc, sender: self)
        }
    }
    
}

extension ServicesDetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 43
        default:
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        default:
            return state == .ownService ? 0 : 90 * KeyWords.widthRatio
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            return nil
        default:
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
            footer.cardView.backgroundColor = selectedServices.count == 0 ? .passiveTextColor : .mainColor
            footer.calculate(selectedServices)
            footer.clickCallback = { [weak self] in
                guard let services = self?.selectedServices, let washer = self?.viewModel?.washer else { return }
                if services.count == 0 {
                    self?.presentErrorAlert(title: "warning", msg: "please select packages!")
                    return 
                }
                let vc = SelectedServicesListVC(services: services, washer: washer)
                self?.show(vc, sender: self)
            }
            return state == .ownService ? nil : footer
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeader.identifier) as! TitleHeader
            header.titleLb.text = "Выберите услугу"
            return header
        default:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServiceSelectionHeader.identifier) as! ServiceSelectionHeader
            header.cardView.backgroundColor = .backgroundColor
            header.initSegments(state: state)
            header.segment1Callback = { [weak self] in
                guard let self = self else { return }
                self.state = .ownService
                self.mainView.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                print("segment1 clicked")
            }
            header.segment2Callback = { [weak self] in
                guard let self = self else { return }
                self.state = .customService
                self.mainView.tableView.reloadSections(IndexSet(integer: 2), with: .fade)
                print("segment2 clicked")
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 104 * KeyWords.widthRatio + 10
        case 1:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            guard let viewModel = viewModel else { return 0 }
            return state == .ownService ? viewModel.servicePackages.value.count : viewModel.services.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WasherCell.identifier, for: indexPath) as! WasherCell
            cell.homeLeading.constant = 0
            cell.backgroundColor = .backgroundColor
            cell.selectionStyle = .none
            cell.cardView.backgroundColor = .backgroundColor
            cell.initData(viewModel.washer)
            return cell
        } else {
            if state == .ownService {
                let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.identifier, for: indexPath) as! ServiceCell
                cell.initData(viewModel.servicePackages.value[indexPath.row])
//              MARK: eger sonky cell bolsa bottom space goymak ucin
                if indexPath.row == 9 {
                    cell.cardBottom.constant = -20
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CustomServiceCell.identifier, for: indexPath) as! CustomServiceCell
                cell.initData(viewModel.services.value[indexPath.row])
                if selectedServices.contains(viewModel.services.value[indexPath.row]) {
                    cell.checkBtn.isSelected = true
                    cell.checkBtn.setImage(UIImage(named: "State=Active"), for: .normal)
                } else {
                    cell.checkBtn.isSelected = false
                    cell.checkBtn.setImage(UIImage(named: "State=Passive"), for: .normal)
                }
                cell.selectedCallback = { [weak self] isSelected in
                    guard let self = self else { return }
                    if isSelected {
                        self.selectedServices.append(viewModel.services.value[indexPath.row])
                    } else {
                        let filtered = self.selectedServices.filter{($0.service_id ?? -1) != viewModel.services.value[indexPath.row].service_id ?? 0}
                        self.selectedServices = filtered
                    }
                    UIView.performWithoutAnimation {
                        self.mainView.tableView.reloadSections(IndexSet(integer: 2), with: .none)
                    }
//                    print(self.selectedServices)
                }
                return cell
            }
        }
    }
    
    
}
