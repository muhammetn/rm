//
//  AddReviewView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit
import Cosmos

class AddReviewView: UIView {
    
    var confirmCallback: (()->())?
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(rgb: 0x101010).withAlphaComponent(0.5)
        return v
    }()
    
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
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let iconImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "comment")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.imageView?.tintColor = .white
        btn.imageView?.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Cancel"), for: .normal)
        return btn
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.text = "Как качество наших услуг".localized()
        return lb
    }()
    
    let textView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentInset = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16)
        v.textColor = .white
        v.backgroundColor = .cardColor
        v.font = UIFont(font: .B1Regular)
        v.text = "Ваш отзыв".localized()
        v.textColor = .passiveTextColor
        return v
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .mainColor
        btn.setTitle("Продолжить".localized(), for: .normal)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        return btn
    }()
    
    let ratingView: CosmosView = {
        let v = CosmosView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.settings.starSize = 42
        v.settings.filledColor = .mainColor
        v.settings.emptyBorderColor = .passiveTextColor
        v.settings.emptyBorderWidth = 1.5
        v.settings.starMargin = 30
        v.settings.totalStars = 5
        v.settings.filledImage = UIImage(named: "star-fill")
        v.settings.emptyImage = UIImage(named: "star-empty")
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
        button.layer.cornerRadius = 4
        textView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        addSubview(scrollView)
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        scrollView.addSubview(cardView)
        scrollView.addSubview(iconImg)
        cardView.addSubview(closeBtn)
        cardView.addSubview(titleLb)
        cardView.addSubview(textView)
        cardView.addSubview(ratingView)
        cardView.addSubview(button)
        button.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    private func setupLayout() {
        let layoutGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 517 * KeyWords.widthRatio),
            cardView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            closeBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            closeBtn.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            closeBtn.heightAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            closeBtn.widthAnchor.constraint(equalToConstant: 24 * KeyWords.widthRatio),
            
            iconImg.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconImg.centerYAnchor.constraint(equalTo: cardView.topAnchor),
            iconImg.heightAnchor.constraint(equalToConstant: 62 * KeyWords.widthRatio),
            iconImg.widthAnchor.constraint(equalToConstant: 62 * KeyWords.widthRatio),
            
            titleLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 66),
            titleLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 48),
            titleLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -48),
            
            ratingView.topAnchor.constraint(equalTo: titleLb.bottomAnchor, constant: 15),
            ratingView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            ratingView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            
            textView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            textView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            textView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 35),
            textView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -30),
            
            button.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -15),
            button.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
        ])
    }
    
    @objc func clickConfirm() {
        confirmCallback?()
    }
    
}
