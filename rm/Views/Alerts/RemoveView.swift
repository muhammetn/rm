//
//  RemoveView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 30.01.2023.
//

import UIKit

class RemoveAlertView: UIView {
    
    let blurEffectView: UIVisualEffectView = {
        var blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
    }()
    
    let cardView: TransparentHoleView = {
        let v = TransparentHoleView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let iconImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "remove")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Вы уверены, что хотите удалить?"
        return lb
    }()
    
//    let descLb: UILabel = {
//        let lb = UILabel()
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.font = UIFont(font: .B1Regular)
//        lb.textColor = .passiveTextColor
//        lb.textAlignment = .center
//        lb.numberOfLines = 0
//        lb.text = "Ваш заказ отправлен администратору, пожалуйста, подождите, вы можете отслеживать статус заказа в разделе статуса"
//        return lb
//    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setTitle("Отменить", for: .normal)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        return btn
    }()
    
    let removeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .redColorr
        btn.setTitle("Да, удалить", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        return btn
    }()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.spacing = 15
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.layer.cornerRadius = 4
        cancelBtn.layer.cornerRadius = 4
        removeBtn.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = UIColor(rgb: 0x101010).withAlphaComponent(0.5)
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        addSubview(cardView)
        addSubview(iconImg)
        cardView.addSubview(titleLb)
//        cardView.addSubview(descLb)
        cardView.addSubview(stackView)
        stackView.addArrangedSubview(cancelBtn)
        stackView.addArrangedSubview(removeBtn)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            iconImg.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconImg.centerYAnchor.constraint(equalTo: cardView.topAnchor),
            iconImg.heightAnchor.constraint(equalToConstant: 62 * KeyWords.widthRatio),
            iconImg.widthAnchor.constraint(equalToConstant: 62 * KeyWords.widthRatio),
            
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 66),
            titleLb.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24),
        ])
    }
    
}
