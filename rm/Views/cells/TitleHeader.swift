//
//  TitleHeader.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class TitleHeader: UITableViewHeaderFooterView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.textColor = .white
        return lb
    }()
    
    lazy var titleCenterY = titleLb.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5)
    lazy var titleLeading = titleLb.leadingAnchor.constraint(equalTo: leadingAnchor)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.backgroundColor = .backgroundColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor),
        ])
        if #available(iOS 15.0, *) {
            titleLeading.isActive = true
        } else {
            titleCenterY.isActive = true
        }
    }
    
}
