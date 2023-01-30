//
//  ServicesDetailView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class ServicesDetailView: UIView {
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .backgroundColor
        tb.register(WasherCell.self, forCellReuseIdentifier: WasherCell.identifier)
        tb.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.identifier)
        tb.register(CustomServiceCell.self, forCellReuseIdentifier: CustomServiceCell.identifier)
        tb.register(ServiceSelectionHeader.self, forHeaderFooterViewReuseIdentifier: ServiceSelectionHeader.identifier)
        tb.register(TitleHeader.self, forHeaderFooterViewReuseIdentifier: TitleHeader.identifier)
        tb.register(PriceFooterView.self, forHeaderFooterViewReuseIdentifier: PriceFooterView.identifier)
        tb.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tb.sectionHeaderTopPadding = 0
        } else { }
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundColor
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
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
