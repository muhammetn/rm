//
//  WasherCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class WasherCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let homeImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .mainColor
        img.image = UIImage(named: "Garage")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let carImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .passiveTextColor
        img.image = UIImage(named: "Car")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let washerLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H2)
        lb.textColor = .white
        return lb
    }()
    
    let queueLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Regular)
        lb.textColor = .white
        return lb
    }()
    
    let statusBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Свободно".localized(), for: .normal)
        btn.titleLabel?.font = UIFont(font: .B1Regular)
        btn.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        btn.backgroundColor = .greenColorr
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    lazy var homeLeading = homeImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
    
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
        statusBtn.layer.cornerRadius = 4
        cardView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        addSubview(cardView)
        cardView.addSubview(homeImg)
        cardView.addSubview(carImg)
        cardView.addSubview(statusBtn)
        cardView.addSubview(washerLb)
        cardView.addSubview(queueLb)
        washerLb.text = "Мойщик #2"
        queueLb.text = "нет машин в очереди"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 104 * KeyWords.widthRatio),
            
            homeLeading,
            homeImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            homeImg.heightAnchor.constraint(equalToConstant: 30 * KeyWords.widthRatio),
            homeImg.widthAnchor.constraint(equalToConstant: 30 * KeyWords.widthRatio),
            
            carImg.leadingAnchor.constraint(equalTo: homeImg.leadingAnchor),
            carImg.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            carImg.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            carImg.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
            washerLb.centerYAnchor.constraint(equalTo: homeImg.centerYAnchor),
            washerLb.trailingAnchor.constraint(equalTo: statusBtn.trailingAnchor, constant: -16),
            washerLb.leadingAnchor.constraint(equalTo: homeImg.trailingAnchor, constant: 16),
            
            queueLb.leadingAnchor.constraint(equalTo: carImg.trailingAnchor, constant: 10),
            queueLb.centerYAnchor.constraint(equalTo: carImg.centerYAnchor),
            queueLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            statusBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            statusBtn.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            
        ])
    }
    
    func initData(_ washer: Washer) {
        washerLb.text = washer.getName()
        if washer.car_in_process ?? 0 == 0 {
            queueLb.text = "нет машин в очереди".localized()
            statusBtn.backgroundColor = .greenColorr
            statusBtn.setTitle("Свободно".localized(), for: .normal)
            statusBtn.isEnabled = true
        } else {
            let str = "машины в очереди".localized()
            queueLb.text = "\(washer.car_in_process ?? 1) \(str)"
            statusBtn.backgroundColor = .redColorr
            statusBtn.setTitle("Занято".localized(), for: .normal)
            statusBtn.isEnabled = false
        }
    }
    
}
