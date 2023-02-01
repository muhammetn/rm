//
//  StatusDetailCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 27.01.2023.
//

import UIKit

class StatusDetailCell: UITableViewCell {
    
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
        lb.text = "ASDs"
        lb.textColor = .white
        return lb
    }()
    
    let priceIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "coin")
        return img
    }()
    
    let timeIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "clock-outline")
        return img
    }()
    
    let personIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "user")
        return img
    }()
    
    let carIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Car")
        return img
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let timeLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let personLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let carLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.spacing = 16
        v.distribution = .equalSpacing
        v.axis = .vertical
        return v
    }()
    
    let strokeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()
    
    let statusImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "statusDetailStatus1")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let acceptedImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Check")
        return img
    }()
    
    let acceptedLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        return lb
    }()
    
    let onProcessImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "timer")
        return img
    }()
    
    let onProcessLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        return lb
    }()
    
    let completedImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Done")
        return img
    }()
    
    let completedLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .passiveTextColor
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
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
        cardView.addSubview(priceIconImg)
        cardView.addSubview(priceLb)
        cardView.addSubview(timeIconImg)
        cardView.addSubview(timeLb)
        
        cardView.addSubview(personIconImg)
        cardView.addSubview(personLb)
        
        cardView.addSubview(carIconImg)
        cardView.addSubview(carLb)
        
        cardView.addSubview(strokeView)
        cardView.addSubview(statusImg)
        
        cardView.addSubview(acceptedImg)
        cardView.addSubview(acceptedLb)
        cardView.addSubview(onProcessImg)
        cardView.addSubview(onProcessLb)
        cardView.addSubview(completedImg)
        cardView.addSubview(completedLb)
        
        priceLb.text = "75 TMT"
        timeLb.text = "30.12.2022 | 18:21"
        personLb.text = "3 человек"
        carLb.text = "Седан • Хэтчбек • Универсал"
        
        acceptedLb.text = "Принять"
        onProcessLb.text = "В процессе"
        completedLb.text = "Завершён"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            
            priceIconImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            priceIconImg.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 16),
            priceIconImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            priceIconImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            priceLb.leadingAnchor.constraint(equalTo: priceIconImg.trailingAnchor, constant: 10),
            priceLb.centerYAnchor.constraint(equalTo: priceIconImg.centerYAnchor),
            priceLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            timeIconImg.leadingAnchor.constraint(equalTo: priceIconImg.leadingAnchor),
            timeIconImg.topAnchor.constraint(equalTo: priceIconImg.bottomAnchor, constant: 16),
            timeIconImg.widthAnchor.constraint(equalTo: priceIconImg.widthAnchor),
            timeIconImg.heightAnchor.constraint(equalTo: priceIconImg.heightAnchor),
            
            timeLb.leadingAnchor.constraint(equalTo: priceLb.leadingAnchor),
            timeLb.trailingAnchor.constraint(equalTo: priceLb.trailingAnchor),
            timeLb.centerYAnchor.constraint(equalTo: timeIconImg.centerYAnchor),
            
            personIconImg.leadingAnchor.constraint(equalTo: timeIconImg.leadingAnchor),
            personIconImg.topAnchor.constraint(equalTo: timeIconImg.bottomAnchor, constant: 16),
            personIconImg.widthAnchor.constraint(equalTo: timeIconImg.widthAnchor),
            personIconImg.heightAnchor.constraint(equalTo: timeIconImg.heightAnchor),
            
            personLb.leadingAnchor.constraint(equalTo: priceLb.leadingAnchor),
            personLb.trailingAnchor.constraint(equalTo: priceLb.trailingAnchor),
            personLb.centerYAnchor.constraint(equalTo: personIconImg.centerYAnchor),
            
            carIconImg.leadingAnchor.constraint(equalTo: personIconImg.leadingAnchor),
            carIconImg.heightAnchor.constraint(equalTo: personIconImg.heightAnchor),
            carIconImg.widthAnchor.constraint(equalTo: personIconImg.widthAnchor),
            carIconImg.topAnchor.constraint(equalTo: personIconImg.bottomAnchor, constant: 16),
            
            carLb.leadingAnchor.constraint(equalTo: timeLb.leadingAnchor),
            carLb.trailingAnchor.constraint(equalTo: timeLb.trailingAnchor),
            carLb.centerYAnchor.constraint(equalTo: carIconImg.centerYAnchor),
            
            strokeView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            strokeView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            strokeView.topAnchor.constraint(equalTo: carLb.bottomAnchor, constant: 15),
            strokeView.heightAnchor.constraint(equalToConstant: 1),
            
            statusImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 23),
            statusImg.topAnchor.constraint(equalTo: strokeView.topAnchor, constant: 27),
            statusImg.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            acceptedImg.leadingAnchor.constraint(equalTo: statusImg.trailingAnchor, constant: 15),
            acceptedImg.topAnchor.constraint(equalTo: statusImg.topAnchor),
            acceptedImg.widthAnchor.constraint(equalToConstant: 24),
            acceptedImg.heightAnchor.constraint(equalToConstant: 24),
            
            acceptedLb.leadingAnchor.constraint(equalTo: acceptedImg.trailingAnchor, constant: 10),
            acceptedLb.centerYAnchor.constraint(equalTo: acceptedImg.centerYAnchor),
            
            onProcessImg.leadingAnchor.constraint(equalTo: acceptedImg.leadingAnchor),
            onProcessImg.centerYAnchor.constraint(equalTo: statusImg.centerYAnchor),
            onProcessImg.heightAnchor.constraint(equalTo: acceptedImg.heightAnchor),
            onProcessImg.widthAnchor.constraint(equalTo: acceptedImg.widthAnchor),
            
            onProcessLb.leadingAnchor.constraint(equalTo: acceptedLb.leadingAnchor),
            onProcessLb.centerYAnchor.constraint(equalTo: onProcessImg.centerYAnchor),
            
            completedImg.bottomAnchor.constraint(equalTo: statusImg.bottomAnchor),
            completedImg.leadingAnchor.constraint(equalTo: acceptedImg.leadingAnchor),
            completedImg.widthAnchor.constraint(equalTo: acceptedImg.widthAnchor),
            completedImg.heightAnchor.constraint(equalTo: acceptedImg.heightAnchor),
            
            completedLb.leadingAnchor.constraint(equalTo: acceptedLb.leadingAnchor),
            completedLb.centerYAnchor.constraint(equalTo: completedImg.centerYAnchor),
            
        ])
    }
    
}
