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
        lb.text = "Сервисы"
        return lb
    }()
    
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
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
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
            cardView.addSubview(nameLb)
            cardView.addSubview(stroke)
            if count == 0 {
                NSLayoutConstraint.activate([
                    nameLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    nameLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -88),
                    nameLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
                    
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
                    
                    stroke.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
                    stroke.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
                    stroke.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
                    stroke.heightAnchor.constraint(equalToConstant: 1),
                ])
            }
            lastItem = nameLb
            count += 1
        }
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
