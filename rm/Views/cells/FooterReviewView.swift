//
//  FooterReviewView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 31.01.2023.
//

import UIKit

class FooterReviewView: UITableViewHeaderFooterView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var clickCallback: (()->())?
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let addReviewView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .mainColor
        v.isUserInteractionEnabled = true
        v.backgroundColor = .passiveTextColor
        return v
    }()
    
    let addReviewImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "bubble-star")
        img.contentMode = .scaleAspectFit
        img.tintColor = .backgroundColor
        return img
    }()
    
    let addReviewLb: UILabel = {
        let lb = UILabel()
//        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .cardColor
        lb.text = "Ваш отзыв".localized()
        return lb
    }()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.spacing = 10
//        v.distribution = .fillEqually
        v.axis = .horizontal
        return v
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4
        addReviewView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        contentView.backgroundColor = .backgroundColor
        contentView.addSubview(cardView)
        cardView.addSubview(addReviewView)
        addReviewView.addSubview(stackView)
        
        stackView.addArrangedSubview(addReviewImg)
        stackView.addArrangedSubview(addReviewLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickAddReview))
        addReviewView.addGestureRecognizer(rec)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 80 * KeyWords.widthRatio),
            
            addReviewView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            addReviewView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            addReviewView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            addReviewView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: addReviewView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: addReviewView.centerXAnchor),
            
            addReviewImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            addReviewImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
        ])
    }
    
    @objc func clickAddReview() {
        clickCallback?()
    }
    
}
