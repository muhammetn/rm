//
//  PackageServiceTopCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class PackageServiceInfoCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let icon1Img: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "clock-outline")
        return img
    }()
    
    let icon2Img: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "user")
        return img
    }()
    
    let title1Lb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Regular)
        lb.text = "40 минут"
        lb.textColor = .white
        return lb
    }()
    
    let title2Lb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Regular)
        lb.text = "Минимум 1 мойщик"
        lb.textColor = .white
        return lb
    }()
    
    let stroke1View: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()
    
    let vipLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.text = "Это VIP сервис, без очереди на мойку, не нужно выбирать время"
        return lb
    }()
    
    let stroke2View: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()

    lazy var strokeBottomConstraints = NSLayoutConstraint()
    lazy var iconBottomConstraints = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(cardView)
        cardView.addSubview(icon1Img)
        cardView.addSubview(title1Lb)
        cardView.addSubview(icon2Img)
        cardView.addSubview(title2Lb)
        cardView.addSubview(stroke1View)
        cardView.addSubview(vipLb)
        cardView.addSubview(stroke2View)
    }
    
    private func setupConstraints() {
        strokeBottomConstraints = stroke2View.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 0)
        iconBottomConstraints = icon1Img.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            icon1Img.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            icon1Img.topAnchor.constraint(equalTo: cardView.topAnchor),
            icon1Img.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            icon1Img.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
            title1Lb.centerYAnchor.constraint(equalTo: icon1Img.centerYAnchor),
            title1Lb.leadingAnchor.constraint(equalTo: icon1Img.trailingAnchor, constant: 10),
            title1Lb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            icon2Img.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            icon2Img.topAnchor.constraint(equalTo: icon1Img.bottomAnchor, constant: 15),
            icon2Img.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            icon2Img.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
            title2Lb.leadingAnchor.constraint(equalTo: icon2Img.trailingAnchor, constant: 10),
            title2Lb.centerYAnchor.constraint(equalTo: icon2Img.centerYAnchor),
            title2Lb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            stroke1View.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            stroke1View.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            stroke1View.topAnchor.constraint(equalTo: title2Lb.bottomAnchor, constant: 15),
            stroke1View.heightAnchor.constraint(equalToConstant: 1),
            
            vipLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            vipLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            vipLb.topAnchor.constraint(equalTo: stroke1View.bottomAnchor, constant: 15),
            
            stroke2View.topAnchor.constraint(equalTo: vipLb.bottomAnchor, constant: 15),
            stroke2View.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            stroke2View.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            stroke2View.heightAnchor.constraint(equalToConstant: 1),
        ])
        
    }
    
    
    func activateIconBottom() {
        strokeBottomConstraints.isActive = false
        iconBottomConstraints.isActive = true
        icon2Img.isHidden = true
        title2Lb.isHidden = true
        stroke1View.isHidden = true
        stroke2View.isHidden = true
        vipLb.isHidden = true
        
    }
    
    func activateStrokeBottom() {
        iconBottomConstraints.isActive = false
        strokeBottomConstraints.isActive = true
        icon2Img.isHidden = false
        title2Lb.isHidden = false
        stroke1View.isHidden = false
        stroke2View.isHidden = false
        vipLb.isHidden = false
        
    }
}


