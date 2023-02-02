//
//  CarSelectionCell.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class CarSelectionCell: UICollectionViewCell {
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    let carImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    override var isSelected: Bool {
        willSet {
            UIView.animate(withDuration: 0.2) { [self] in
                backgroundColor = newValue ? UIColor.mainColor : UIColor.cardColor
                titleLb.textColor = newValue ? UIColor.backgroundColor : UIColor.white
            }
        }
    }
    
    static var identifier: String {
        return String(describing: self)
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
        carImageView.layer.cornerRadius = 4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImageView.image = nil
    }
    
    private func setupViews() {
        backgroundColor = .cardColor
        addSubview(titleLb)
        addSubview(carImageView)
        titleLb.text = "Седан • Хэтчбек • Универсал".localized()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLb.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLb.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            carImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            carImageView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
        ])
    }
    
    func initData(_ car: Car) {
        titleLb.text = car.getTitle()
        carImageView.sdImageLoad(imgUrl: car.image)
    }
    
}
