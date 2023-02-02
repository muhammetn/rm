//
//  CarDetailCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class CarDetailCell: UITableViewCell {
    
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
        lb.text = "О машине".localized()
        return lb
    }()
    
    let carImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .passiveTextColor
        img.image = UIImage(named: "Car")
        return img
    }()
    
    let carLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        lb.text = "Camry • AY 8512"
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        contentView.backgroundColor = .backgroundColor
        contentView.addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(carImg)
        cardView.addSubview(carLb)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            
            carImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            carImg.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 16),
            carImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            carImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            carImg.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            carLb.leadingAnchor.constraint(equalTo: carImg.trailingAnchor, constant: 10),
            carLb.centerYAnchor.constraint(equalTo: carImg.centerYAnchor),
        ])
    }
    
    func initData(order: Order) {
        carLb.text = "\(order.car_type ?? "") • \(order.car_no ?? "")"
    }
}
