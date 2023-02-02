//
//  CustomServiceCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit


class CustomServiceCell: UITableViewCell {
    
    var selectedCallback: ((Bool)->())?
    
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
    
    let checkBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "State=Passive"), for: .normal)
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
        selectionStyle = .none
        backgroundColor = .backgroundColor
        contentView.addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(checkBtn)
        cardView.addSubview(lineView)
        cardView.addSubview(priceLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickCell))
        cardView.addGestureRecognizer(rec)
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
            
            checkBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            checkBtn.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            checkBtn.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            checkBtn.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            titleLb.leadingAnchor.constraint(equalTo: checkBtn.trailingAnchor, constant: 10),
            titleLb.topAnchor.constraint(equalTo: checkBtn.topAnchor),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            lineView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            lineView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            priceLb.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            priceLb.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            priceLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
            
        ])
    }
    
    func initData(_ service: Service) {
        titleLb.text = service.getTitle()
        priceLb.text = "\(service.getPrice()) TMT"
    }
    
    @objc func clickCell() {
        checkBtn.isSelected = !checkBtn.isSelected
        let img = checkBtn.isSelected ? UIImage(named: "State=Active") : UIImage(named: "State=Passive")
        UIView.transition(with: checkBtn, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.checkBtn.setImage(img, for: .normal)
        }, completion: nil)
        selectedCallback?(checkBtn.isSelected)
    }
}
