//
//  EditeCarCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class EditeCarCell:  UITableViewCell {
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .passiveTextColor
        lb.font = UIFont(font: .S1Semibold)
        return lb
    }()
    
    let editeImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "edit")
        img.tintColor = .mainColor
        return img
    }()
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .mainColor
        return lb
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
        addSubview(titleLb)
        addSubview(cardView)
        cardView.addSubview(editeImageView)
        cardView.addSubview(nameLb)
        titleLb.text = "Вы можете изменить тип машины здесь:"
        nameLb.text = AuthHelper.shared.getCarName
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLb.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLb.topAnchor.constraint(equalTo: topAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 10),
            cardView.heightAnchor.constraint(equalToConstant: 52 * KeyWords.widthRatio),
            
            editeImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            editeImageView.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            editeImageView.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            editeImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            nameLb.leadingAnchor.constraint(equalTo: editeImageView.trailingAnchor, constant: 10),
            nameLb.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            nameLb.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor, constant: -16),
            
        ])
        
    }
    
}
