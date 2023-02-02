//
//  ChangePhoneView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit

class ChangePhoneView: UIView {
    
    var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let logoImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logo")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
    let prefixLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .passiveTextColor
        lb.text = "+993"
        return lb
    }()
    
    let phoneField: CustomTextField = {
        let field = CustomTextField(padding: UIEdgeInsets(top: 16, left: 52 * KeyWords.widthRatio, bottom: 16, right: 16))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isUserInteractionEnabled = true
        field.backgroundColor = .cardColor
        field.font = UIFont(font: .B1Regular)
        field.keyboardType = .numberPad
        field.attributedPlaceholder = NSAttributedString(
            string: "65 65 64 63",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor]
        )
        field.textColor = .white
        return field
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .passiveTextColor
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("Dowam et".localized(), for: .normal)
        return btn
    }()
    
    let bottomLogoImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logoWithTitle")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        confirmBtn.layer.cornerRadius = 4
        phoneField.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(scrollView)
        addSubview(bottomLogoImg)
        scrollView.addSubview(cardView)
        cardView.addSubview(logoImg)
        cardView.addSubview(descLb)
        cardView.addSubview(phoneField)
        cardView.addSubview(prefixLb)
        cardView.addSubview(confirmBtn)
        descLb.text = "Üýtgetjek bolýan telefon beligiňiz giriziň".localized()
        
    }
    
    private func setupConstraints() {
        let layoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomLogoImg.topAnchor, constant: -5),
            
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: 10),
            
            logoImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 40 * KeyWords.widthRatio),
            logoImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 95),
            logoImg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -95),
            
            descLb.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 45),
            descLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            phoneField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            phoneField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            phoneField.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 42),
            phoneField.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            prefixLb.leadingAnchor.constraint(equalTo: phoneField.leadingAnchor, constant: 15),
            prefixLb.centerYAnchor.constraint(equalTo: phoneField.centerYAnchor),
            
            confirmBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            confirmBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            confirmBtn.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 65),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            bottomLogoImg.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            bottomLogoImg.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
}
