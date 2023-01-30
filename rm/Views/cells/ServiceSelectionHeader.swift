//
//  ServiceSelectionHeader.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class ServiceSelectionHeader: UITableViewHeaderFooterView {
    
    var segment1Callback: (()->())?
    var segment2Callback: (()->())?
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let tabBarView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .passiveTextColor
        v.backgroundColor = .cardColor
        return v
    }()
    
    let serviceStackView: UIStackView = {
        let v = UIStackView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.distribution = .fill
        v.alignment = .center
        v.spacing = 5
        v.axis = .horizontal
        return v
    }()
    
    let customServiceStackView: UIStackView = {
        let v = UIStackView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.distribution = .fill
        v.alignment = .center
        v.spacing = 5
        v.axis = .horizontal
        return v
    }()
    
    let img1: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "database-script")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLb1: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .passiveTextColor
        lb.textAlignment = .center
        lb.text = "Вид услуги"
        return lb
    }()
    
    let titleLb2: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .passiveTextColor
        lb.textAlignment = .center
        lb.text = "Выберите сами"
        return lb
    }()
    
    let img2: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "hand")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let segment1Btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .cardColor
        return btn
    }()
    
    let segment2Btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .cardColor
        return btn
    }()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tabBarView.layer.cornerRadius = 4
        segment1Btn.layer.cornerRadius = 4
        segment2Btn.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        addSubview(cardView)
        cardView.addSubview(tabBarView)
        tabBarView.addSubview(segment1Btn)
        tabBarView.addSubview(segment2Btn)
        
        tabBarView.addSubview(serviceStackView)
        tabBarView.addSubview(customServiceStackView)
        
        serviceStackView.addArrangedSubview(img1)
        serviceStackView.addArrangedSubview(titleLb1)
        
        customServiceStackView.addArrangedSubview(img2)
        customServiceStackView.addArrangedSubview(titleLb2)
        
        segment1Btn.addTarget(self, action: #selector(clickSegment1), for: .touchUpInside)
        segment2Btn.addTarget(self, action: #selector(clickSegment2), for: .touchUpInside)
        
        let segment1Click = UITapGestureRecognizer(target: self, action: #selector(clickSegment1))
        let segment2Click = UITapGestureRecognizer(target: self, action: #selector(clickSegment2))
        
        serviceStackView.addGestureRecognizer(segment1Click)
        customServiceStackView.addGestureRecognizer(segment2Click)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tabBarView.topAnchor.constraint(equalTo: cardView.topAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            img1.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            img1.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            img2.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            img2.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            segment1Btn.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 5),
            segment1Btn.trailingAnchor.constraint(equalTo: tabBarView.centerXAnchor, constant: -5),
            segment1Btn.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 5),
            segment1Btn.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -5),
            
            segment2Btn.leadingAnchor.constraint(equalTo: tabBarView.centerXAnchor, constant: 5),
            segment2Btn.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -5),
            segment2Btn.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 5),
            segment2Btn.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -5),
            
            serviceStackView.centerXAnchor.constraint(equalTo: segment1Btn.centerXAnchor, constant: -5),
            serviceStackView.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 5),
            serviceStackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -5),
            
            customServiceStackView.centerXAnchor.constraint(equalTo: segment2Btn.centerXAnchor, constant: -5),
            customServiceStackView.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 5),
            customServiceStackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor, constant: -5),
        ])
    }
    
    func initSegments(state: State) {
        if state == .ownService {
            clickSegment1()
        } else {
            clickSegment2()
        }
    }
    
    @objc private func clickSegment1() {
        UIView.animate(withDuration: 0.2) { [self] in
            segment1Btn.backgroundColor = .mainColor
            segment2Btn.backgroundColor = .cardColor
            
            img2.tintColor = .passiveTextColor
            titleLb2.textColor = .passiveTextColor
            
            img1.tintColor = .backgroundColor
            titleLb1.textColor = .backgroundColor
        }
        segment1Callback?()
    }
    
    @objc private func clickSegment2() {
        UIView.animate(withDuration: 0.2) { [self] in
            segment1Btn.backgroundColor = .cardColor
            segment2Btn.backgroundColor = .mainColor
            
            img2.tintColor = .backgroundColor
            titleLb2.textColor = .backgroundColor
            
            img1.tintColor = .passiveTextColor
            titleLb1.textColor = .passiveTextColor
        }
        segment2Callback?()
    }
        
}

