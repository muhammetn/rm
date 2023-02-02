//
//  ServiceCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        lb.numberOfLines = 0
        return lb
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .mainColor
        return lb
    }()
    
    lazy var cardBottom = cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardBottom.constant = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4
    }
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .backgroundColor
        addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(priceLb)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cardBottom,
            
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
//            titleLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            
            priceLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 16),
            priceLb.leadingAnchor.constraint(equalTo: titleLb.leadingAnchor),
            priceLb.trailingAnchor.constraint(equalTo: titleLb.trailingAnchor),
            priceLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }
    
    func initData(_ servicePackage: ServicePackage) {
        titleLb.text = servicePackage.getTitle()
        priceLb.text = "\(servicePackage.getPrice()) TMT"
    }
    
}
