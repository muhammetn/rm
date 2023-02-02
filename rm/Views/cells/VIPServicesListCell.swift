//
//  VIPServiceListCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class VIPServicesListCell: UITableViewCell {
    
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
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        return lb
    }()
    
    let iconImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .mainColor
        img.image = UIImage(named: "vip")
        return img
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        return lb
    }()
    
    let lineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .mainColor
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
        backgroundColor = .backgroundColor
        addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(iconImg)
        cardView.addSubview(descLb)
        cardView.addSubview(lineView)
        cardView.addSubview(priceLb)
//        titleLb.text = "VIP - Експресс"
//        descLb.text = "Услуга без очереди и два мойшики. Время примерно 30минут"
//        priceLb.text = ""
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            cardView.heightAnchor.constraint(equalToConstant: 150),
            
            iconImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            iconImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            iconImg.heightAnchor.constraint(equalToConstant: 32 * KeyWords.widthRatio),
            iconImg.widthAnchor.constraint(equalToConstant: 32 * KeyWords.widthRatio),
            
            titleLb.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor, constant: 10),
            titleLb.centerYAnchor.constraint(equalTo: iconImg.centerYAnchor),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            descLb.leadingAnchor.constraint(equalTo: iconImg.leadingAnchor),
            descLb.topAnchor.constraint(equalTo: iconImg.bottomAnchor, constant: 10),
            descLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            lineView.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 16),
            lineView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            priceLb.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            priceLb.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            priceLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }
    
    func initData(_ service: Service) {
        priceLb.text = "\(service.getPrice()) TMT"
        descLb.text = service.getDesc()
        titleLb.text = service.getTitle()
        
    }
    
}
