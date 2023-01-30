//
//  ServicesVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class StatusVC: UIViewController {
    
    let rowCount = 10
    
    let mainView = StatusView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Статусы"
        navigationItem.largeTitleDisplayMode = .always
        extendedLayoutIncludesOpaqueBars = true
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
}


extension StatusVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StatusDetailVC()
        show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeader.identifier) as! TitleHeader
        header.titleLeading.isActive = false
        header.titleCenterY.isActive = true
        header.titleCenterY.constant = 0
        header.titleLb.text = "12321"
        return header
    }

}

extension StatusVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCell.identifier, for: indexPath) as! StatusCell
//        cell.backgroundColor = .gray
        return cell
    }
    
    
}
