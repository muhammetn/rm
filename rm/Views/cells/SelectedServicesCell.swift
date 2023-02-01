//
//  SelectedServicesCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class SelectedServicesCell: UITableViewCell {
    
    var selectedCallback: (()->())?
    var removeCallback: (()->())?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        return lb
    }()
    
    let removeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Trash"), for: .normal)
        return btn
    }()
    
    let lineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .strokeColor
        return v
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .mainColor
        return lb
    }()
    
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
        backgroundColor = .backgroundColor
        contentView.addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(removeBtn)
        cardView.addSubview(lineView)
        cardView.addSubview(priceLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickCell))
        cardView.addGestureRecognizer(rec)
        
        removeBtn.addTarget(self, action: #selector(clickRem), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -50),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            
            removeBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            removeBtn.centerYAnchor.constraint(equalTo: titleLb.centerYAnchor),
            removeBtn.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            removeBtn.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
            lineView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            lineView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            priceLb.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            priceLb.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            priceLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
            
        ])
    }
    
    func initData(service: Service) {
        priceLb.text = "\(service.getPrice()) TMT"
        titleLb.text = "\(service.getTitle())"
    }
    
    @objc func clickCell() {
        selectedCallback?()
    }
    
    @objc func clickRem() {
        removeCallback?()
    }
    
}
