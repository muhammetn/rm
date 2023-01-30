//
//  VIPPackageServiceView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class VIPPackageServiceView: UIView {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .backgroundColor
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.showsVerticalScrollIndicator = false
        tb.register(PackageServiceInfoCell.self, forCellReuseIdentifier: PackageServiceInfoCell.identifier)
        tb.register(FormsCell.self, forCellReuseIdentifier: FormsCell.identifier)
        tb.register(TimeCheckCell.self, forCellReuseIdentifier: TimeCheckCell.identifier)
        tb.register(PriceFooterView.self, forHeaderFooterViewReuseIdentifier: PriceFooterView.identifier)
        tb.separatorStyle = .none
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
