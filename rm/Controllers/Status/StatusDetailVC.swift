//
//  StatusDetailVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class StatusDetailVC: UIViewController {
    
    let mainView = StatusDetailView()
    
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailCell.identifier, for: indexPath) as! CarDetailCell
        cell.backgroundColor = .gray
        return cell
    }
}
