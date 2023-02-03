//
//  DateCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 19.01.2023.
//

import UIKit

class DateCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let dayLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B3)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Çarşenbe"
        return lb
    }()
    
    let dateLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "11 Ýanwar"
        return lb
    }()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 5 * KeyWords.widthRatio
        return v
    }()
    
    override var isSelected: Bool {
        willSet {
            UIView.animate(withDuration: 0.2) { [self] in
                backgroundColor = newValue ? UIColor.mainColor : UIColor.cardColor
                dayLb.textColor = newValue ? UIColor.backgroundColor : UIColor.white
                dateLb.textColor = newValue ? UIColor.backgroundColor : UIColor.white
            }
        }
    }
    
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
        layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = .cardColor
        addSubview(stackView)
        stackView.addArrangedSubview(dayLb)
        stackView.addArrangedSubview(dateLb)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16 * KeyWords.widthRatio),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16 * KeyWords.widthRatio),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    func initDate(day: String, month: String, dayName: String) {
        dayLb.text = dayName.localized()
        dateLb.text = "\(day) \(month)"
    }
    
}
