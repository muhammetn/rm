//
//  StatusCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 20.01.2023.
//

import UIKit

class StatusCell: UITableViewCell {
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let titleLB: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        return lb
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .passiveTextColor
        return lb
    }()
    
    let carModelLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .passiveTextColor
        return lb
    }()
    
    let statusBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("В ожидании", for: .normal)
        btn.backgroundColor = .mainColor
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.font = UIFont(font: .B2)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        return btn
    }()
    
    let statusImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "success")
        return img
    }()
        
    let carImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "Car")
        return img
    }()
    
    let strokeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()
    
    static var identifier: String {
        return String(describing: self)
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
        cardView.layer.cornerRadius = 4
        statusBtn.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(statusImg)
        cardView.addSubview(titleLB)
        cardView.addSubview(descLb)
        cardView.addSubview(strokeView)
        cardView.addSubview(statusBtn)
        cardView.addSubview(carImg)
        cardView.addSubview(carModelLb)
        
        carModelLb.text = "Camry • AY 8512"
        descLb.text = "Перед вами 3 машины в очереди"
        titleLB.text = "Полная мойка (кузов, салон)"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            cardView.heightAnchor.constraint(equalToConstant: 200),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            statusImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            statusImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            statusImg.heightAnchor.constraint(equalToConstant: 52 * KeyWords.widthRatio),
            statusImg.widthAnchor.constraint(equalToConstant: 52 * KeyWords.widthRatio),
            
            titleLB.leadingAnchor.constraint(equalTo: statusImg.trailingAnchor, constant: 10),
            titleLB.topAnchor.constraint(equalTo: statusImg.topAnchor),
            titleLB.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            descLb.leadingAnchor.constraint(equalTo: titleLB.leadingAnchor),
            descLb.topAnchor.constraint(equalTo: titleLB.bottomAnchor, constant: 5),
            descLb.trailingAnchor.constraint(equalTo: titleLB.trailingAnchor),
            
            strokeView.leadingAnchor.constraint(equalTo: statusImg.leadingAnchor),
            strokeView.topAnchor.constraint(equalTo: statusImg.bottomAnchor, constant: 15),
            strokeView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            strokeView.heightAnchor.constraint(equalToConstant: 1),
            
            statusBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            statusBtn.topAnchor.constraint(equalTo: strokeView.bottomAnchor, constant: 15),
            
            carImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            carImg.centerYAnchor.constraint(equalTo: statusBtn.centerYAnchor),
            carImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            carImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            carModelLb.leadingAnchor.constraint(equalTo: carImg.trailingAnchor, constant: 10),
            carModelLb.trailingAnchor.constraint(equalTo: statusBtn.trailingAnchor, constant: -10),
            carModelLb.centerYAnchor.constraint(equalTo: statusBtn.centerYAnchor),
            
            statusBtn.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15),
            
        ])
    }
    
}
