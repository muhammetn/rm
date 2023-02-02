//
//  ServiceDetailCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit


class ServiceDetailCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var lastItem = UILabel()
    
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
        lb.text = "Сервисы".localized()
        return lb
    }()
    
    var order = Order()
    
    var services: [Service]? {
        didSet {
            if oldValue != nil { return }
            guard let services = services else { return }
            createServiceLb(services: services)
        }
    }
    
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
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 15),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
        ])
    }
    
    func createServiceLb(services: [Service]) {
        var count = 0
        services.forEach { service in
            let nameLb = getLb(font: .B1Regular)
            let priceLb = getLb(font: .B1Regular)
            let stroke: UIView = {
                let v = UIView()
                v.translatesAutoresizingMaskIntoConstraints = false
                v.backgroundColor = .strokeColor
                return v
            }()
            nameLb.text = service.getTitle()
            priceLb.textColor = .mainColor
            let price = (order.car_model ?? 0) == 1 ? service.price : service.price_big
            priceLb.text = "+\(price ?? 0) TMT"
            cardView.addSubview(nameLb)
            cardView.addSubview(stroke)
            cardView.addSubview(priceLb)
            if count == 0 {
                NSLayoutConstraint.activate([
                    nameLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    nameLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -88),
                    nameLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
                    
                    priceLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
                    priceLb.centerYAnchor.constraint(equalTo: nameLb.centerYAnchor),
                    
                    stroke.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    stroke.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
                    stroke.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
                    stroke.heightAnchor.constraint(equalToConstant: 1),
                ])
            } else {
                NSLayoutConstraint.activate([
                    nameLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    nameLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -88),
                    nameLb.topAnchor.constraint(equalTo: lastItem.bottomAnchor, constant: 25),
                    
                    priceLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
                    priceLb.centerYAnchor.constraint(equalTo: nameLb.centerYAnchor),
                    
                    stroke.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    stroke.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
                    stroke.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
                    stroke.heightAnchor.constraint(equalToConstant: 1),
                ])
            }
            lastItem = nameLb
            count += 1
        }
        
        let allPriceTextLb = getLb(font: .B1Regular)
        let allPriceLb = getLb(font: .B1Regular)
        allPriceLb.textColor = .mainColor
        cardView.addSubview(allPriceTextLb)
        cardView.addSubview(allPriceLb)
        allPriceTextLb.text = "Итоги:".localized()
        allPriceLb.text = "\(order.total ?? 0) TMT"
        NSLayoutConstraint.activate([
            allPriceTextLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            allPriceTextLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -88),
            allPriceTextLb.topAnchor.constraint(equalTo: lastItem.bottomAnchor, constant: 25),
            
            allPriceTextLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
            allPriceLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            allPriceLb.centerYAnchor.constraint(equalTo: allPriceTextLb.centerYAnchor),
        ])
    }
    
    func getLb(font: Fonts) -> UILabel {
        let lb: UILabel = {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.textColor = .white
            lb.numberOfLines = 0
            lb.font = UIFont(font: font)
            return lb
        }()
        return lb
    }
}
