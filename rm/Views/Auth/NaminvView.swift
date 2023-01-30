//
//  NaminvView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class NamingView: UIView {
    
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
        img.image = UIImage(named: "logoWithTitle")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .mainColor
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("Dowam et", for: .normal)
        return btn
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .passiveTextColor
        return lb
    }()
    
    let nameField: CustomTextField = {
        let field = CustomTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.attributedPlaceholder = NSAttributedString(
            string: "Mysal: Aman Amanow",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor, NSAttributedString.Key.font: UIFont(font: .B1Regular)]
        )
        field.font = UIFont(font: .B1Regular)
        field.textColor = .white
        field.backgroundColor = .cardColor
        return field
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
        nameField.layer.cornerRadius = 4
        confirmBtn.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(scrollView)
        scrollView.addSubview(cardView)
        cardView.addSubview(logoImg)
        cardView.addSubview(titleLb)
        cardView.addSubview(descLb)
        cardView.addSubview(nameField)
        cardView.addSubview(confirmBtn)
        titleLb.text = "Doly adyňyzy giriziň"
        descLb.text = "Bellän adyňyz hyzmatlarymyzy ulanan wagtyňyz sargytlarda görkeziler"
        
    }
    
    private func setupConstraints() {
        let layoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: 10),
            
            logoImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20 * KeyWords.widthRatio),
            logoImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 95),
            logoImg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -95),
            
            titleLb.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 103 * KeyWords.widthRatio),
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            descLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            descLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15 * KeyWords.widthRatio),
            
            nameField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            nameField.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 40 * KeyWords.widthRatio),
            nameField.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            confirmBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            confirmBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            confirmBtn.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 66 * KeyWords.widthRatio),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
        ])
    }
    
}
