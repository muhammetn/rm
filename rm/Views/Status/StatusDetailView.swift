//
//  StatusDetailView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class StatusDetailView: UIView {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        tb.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        tb.backgroundColor = .backgroundColor
        tb.rowHeight  = UITableView.automaticDimension
        tb.showsVerticalScrollIndicator = false
        tb.estimatedRowHeight = 80
        tb.sectionHeaderHeight = 30
        tb.register(StatusDetailCell.self, forCellReuseIdentifier: StatusDetailCell.identifier)
        tb.register(CarDetailCell.self, forCellReuseIdentifier: CarDetailCell.identifier)
        tb.register(ServiceDetailCell.self, forCellReuseIdentifier: ServiceDetailCell.identifier)
        if #available(iOS 15.0, *) {
            tb.sectionHeaderTopPadding = 0
        } else { }
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
