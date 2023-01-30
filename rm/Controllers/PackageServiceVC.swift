//
//  PackageServiceVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class PackageServiceVC: UIViewController {
    
    let mainView = PackageServiceView()
    var service = ServicePackage()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(service: ServicePackage) {
        self.init(nibName: nil, bundle: nil)
        self.service = service
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    }
    
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
        
    }
    
    @objc func clickFooter() {
        let vc = SelectedServicesListVC()
        show(vc, sender: self)
    }
    
}

extension PackageServiceVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 * KeyWords.widthRatio + 10
    }
    
}

extension PackageServiceVC: UITableViewDataSource {
    
    
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
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TimeCheckCell.identifier, for: indexPath) as! TimeCheckCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PriceFooterView.identifier) as! PriceFooterView
        footer.clickCallback = { [weak self] in
            guard let self = self else {
                return
            }
            self.clickFooter()
        }
        return footer
    }
    
    
}
