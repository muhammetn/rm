//
//  CarSelectionVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class CarSelectionView: UIView {
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width-32, height: 224 * KeyWords.widthRatio)
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsVerticalScrollIndicator = false
        v.backgroundColor = .backgroundColor
        v.allowsSelection = true
        v.allowsMultipleSelection = false
        v.register(CarSelectionCell.self, forCellWithReuseIdentifier: CarSelectionCell.identifier)
        return v
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .mainColor
        btn.backgroundColor = .passiveTextColor
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.isEnabled = false
        btn.setTitle("Dowam et".localized(), for: .normal)
        return btn
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
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(titleLb)
        addSubview(descLb)
        addSubview(collectionView)
        addSubview(confirmBtn)
        titleLb.text = "Выберите тип машина".localized()
        descLb.text = "Цены могут меняться в зависимости от выбранного вами типа".localized()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLb.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descLb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descLb.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descLb.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 25),
            collectionView.bottomAnchor.constraint(equalTo: confirmBtn.topAnchor, constant: -20),
            
            confirmBtn.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            confirmBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            confirmBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
}
