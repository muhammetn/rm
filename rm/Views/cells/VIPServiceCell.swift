//
//  VIPServiceCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class VIPServiceCell:  UITableViewCell {
    
    let cardView: UIView = {
        let v = UIView()
        v.backgroundColor = .cardColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let vipImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .mainColor
        img.image = UIImage(named: "vip")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        return lb
    }()
    
    let arrowImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = UIColor(rgb: 0x999999)
        img.image = UIImage(named: "arrow-right-circled")
        img.contentMode = .scaleAspectFit
        return img
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
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        addSubview(cardView)
        cardView.addSubview(vipImg)
        cardView.addSubview(titleLb)
        cardView.addSubview(arrowImg)
        titleLb.text = "Все VIP категория"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            vipImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            vipImg.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            vipImg.heightAnchor.constraint(equalToConstant: 32 * KeyWords.widthRatio),
            vipImg.widthAnchor.constraint(equalToConstant: 32 * KeyWords.widthRatio),
            
            titleLb.leadingAnchor.constraint(equalTo: vipImg.trailingAnchor, constant: 10),
            titleLb.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            arrowImg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            arrowImg.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            arrowImg.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            arrowImg.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
//            titleLb.trailingAnchor.cons
        ])
    }
    
}
