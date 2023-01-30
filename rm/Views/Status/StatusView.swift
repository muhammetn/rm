//
//  StatusView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 20.01.2023.
//

import UIKit

class StatusView: UIView {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        tb.backgroundColor = .backgroundColor
        tb.rowHeight  = UITableView.automaticDimension
        tb.estimatedRowHeight = 80
        tb.sectionHeaderHeight = 30
        tb.register(TitleHeader.self, forHeaderFooterViewReuseIdentifier: TitleHeader.identifier)
        tb.register(StatusCell.self, forCellReuseIdentifier: StatusCell.identifier)
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
        backgroundColor = .backgroundColor
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
