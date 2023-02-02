//
//  PriceFooterView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class PriceFooterView: UITableViewHeaderFooterView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var clickCallback: (()->())?
    
    let cardView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .mainColor
        return v
    }()
    
    let orderLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .backgroundColor
        return lb
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .backgroundColor
        return lb
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
    }
    
    private func setupViews() {
        contentView.backgroundColor = .backgroundColor
        contentView.addSubview(cardView)
        cardView.addSubview(orderLb)
        cardView.addSubview(priceLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickFooter))
        cardView.addGestureRecognizer(rec)
        
        orderLb.text = "Заказать".localized()
        priceLb.text = "Итоговая цена: 230 ТМТ"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            orderLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 25),
            orderLb.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            
            priceLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            priceLb.centerYAnchor.constraint(equalTo: orderLb.centerYAnchor),
        ])
        
    }
    
    func calculate(_ services: [Service]) {
        var price = Double()
        services.forEach { service in
            price += service.getPrice()
        }
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Regular),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        
        let priceAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Semibold),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        let priceStr = "\(price) TMT"
        let allPrice = "Итоговая цена:".localized()
        let myString = NSMutableAttributedString(string: "\(allPrice) \(priceStr)", attributes: attributes)
        myString.addAttributes(priceAttributes, range: NSRange(location: allPrice.count + 1, length: priceStr.count))
        priceLb.attributedText = myString
    }
    
    func calculate(service: ServicePackage) {
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Regular),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        
        let priceAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Semibold),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        let priceStr = "\(service.getPrice()) TMT"
        let allPrice = "Итоговая цена:".localized()
        let myString = NSMutableAttributedString(string: "\(allPrice) \(priceStr)", attributes: attributes)
        myString.addAttributes(priceAttributes, range: NSRange(location: allPrice.count + 1, length: priceStr.count))
        priceLb.attributedText = myString
    }
    
    @objc func clickFooter() {
        clickCallback?()
    }
    
    
}
