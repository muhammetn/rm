//
//  StatusDetailVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class StatusDetailVC: UIViewController {
    
    let mainView = StatusDetailView()
    let service = Service(service_id: 0, title: "dsads", title_ru: "Dsad", price: 213, price_big: 341, description: "sdas", description_ru: "dsa", duration: 232, min_washer: 3)
    lazy var services = [service, service]
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Полная информация"
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
}


extension StatusDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatusDetailCell.identifier, for: indexPath) as! StatusDetailCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailCell.identifier, for: indexPath) as! CarDetailCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceDetailCell.identifier, for: indexPath) as! ServiceDetailCell
            cell.services = services
            cell.backgroundColor = .redColorr
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100 * KeyWords.widthRatio
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterReviewView.identifier) as! FooterReviewView
//        footer.backgroundColor = .gray
        return footer
    }
}
