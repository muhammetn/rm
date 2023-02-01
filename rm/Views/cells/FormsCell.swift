//
//  FormsCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class FormsCell: UITableViewCell {
    
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
        lb.text = "Заполнитe бланки"
        lb.textColor = .white
        lb.font = UIFont(font: .S1Semibold)
        return lb
    }()
    
    let carModelField: CustomTextField = {
        let field = CustomTextField()
        field.tag = 1
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .cardColor
        field.font = UIFont(font: .B1Regular)
        field.attributedPlaceholder = NSAttributedString(
            string: "Модел машин. Например: Tayota Camry",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor]
        )
        field.textColor = .white
        return field
    }()
    
    let carNumberField: CustomTextField = {
        let field = CustomTextField()
        field.tag = 2
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .cardColor
        field.font = UIFont(font: .B1Regular)
        field.attributedPlaceholder = NSAttributedString(
            string: "Номер машин. Например: AY 8512",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor]
        )
        field.textColor = .white
        return field
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
        carModelField.borderStyle = .roundedRect
        carNumberField.borderStyle = .roundedRect
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLb)
        cardView.addSubview(carModelField)
        cardView.addSubview(carNumberField)
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
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            
            carModelField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            carModelField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            carModelField.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
            carModelField.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            carNumberField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            carNumberField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            carNumberField.topAnchor.constraint(equalTo: carModelField.bottomAnchor, constant: 10),
            
            carNumberField.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -15)
            
        ])
    }
}
