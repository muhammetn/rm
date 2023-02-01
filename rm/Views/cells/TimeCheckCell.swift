//
//  TimeCheckCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class TimeCheckCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Когда вы хотите использовать?"
        lb.textColor = .white
        lb.font = UIFont(font: .S1Semibold)
        return lb
    }()
    
    let selectDateCheckBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "State=Passive"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let nowCheckBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "State=Active"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let selectDateTitleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        lb.text = "Забронировать время"
        return lb
    }()
    
    let nowTitleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        lb.text = "Заехать сейчас"
        return lb
    }()
    
    var hiddenSelectionBtn1: UIButton = {
        let btn = UIButton()
        btn.tag = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var hiddenSelectionBtn2: UIButton = {
        let btn = UIButton()
        btn.tag = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var selectionDateCallback: (()->())?
    var nowDateCallback: (()->())?
    
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
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(selectDateCheckBtn)
        cardView.addSubview(nowCheckBtn)
        cardView.addSubview(selectDateTitleLb)
        cardView.addSubview(nowTitleLb)
        cardView.addSubview(hiddenSelectionBtn1)
        cardView.addSubview(hiddenSelectionBtn2)
        
        hiddenSelectionBtn1.addTarget(self, action: #selector(clickSelectionDate), for: .touchUpInside)
        hiddenSelectionBtn2.addTarget(self, action: #selector(clickSelectionDate), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor),
            
            selectDateCheckBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            selectDateCheckBtn.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 20),
            selectDateCheckBtn.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            selectDateCheckBtn.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            nowCheckBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            nowCheckBtn.topAnchor.constraint(equalTo: selectDateCheckBtn.bottomAnchor, constant: 20),
            nowCheckBtn.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            nowCheckBtn.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            selectDateTitleLb.leadingAnchor.constraint(equalTo: selectDateCheckBtn.trailingAnchor, constant: 10),
            selectDateTitleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            selectDateTitleLb.centerYAnchor.constraint(equalTo: selectDateCheckBtn.centerYAnchor),
            
            nowTitleLb.leadingAnchor.constraint(equalTo: nowCheckBtn.trailingAnchor, constant: 10),
            nowTitleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            nowTitleLb.centerYAnchor.constraint(equalTo: nowCheckBtn.centerYAnchor),
            
            nowCheckBtn.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -40),
            
            hiddenSelectionBtn1.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            hiddenSelectionBtn1.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            hiddenSelectionBtn1.topAnchor.constraint(equalTo: selectDateCheckBtn.topAnchor),
            hiddenSelectionBtn1.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            hiddenSelectionBtn2.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            hiddenSelectionBtn2.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            hiddenSelectionBtn2.topAnchor.constraint(equalTo: nowCheckBtn.topAnchor),
            hiddenSelectionBtn2.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
        ])
    }
    
    @objc func clickSelectionDate(_ button: UIButton) {
        if button == hiddenSelectionBtn1 {
            selectDateCheckBtn.setImage(UIImage(named: "State=Active"), for: .normal)
            nowCheckBtn.setImage(UIImage(named: "State=Passive"), for: .normal)
            selectionDateCallback?()
        } else {
            nowCheckBtn.setImage(UIImage(named: "State=Active"), for: .normal)
            selectDateCheckBtn.setImage(UIImage(named: "State=Passive"), for: .normal)
            nowDateCallback?()
        }
    }
    
}
