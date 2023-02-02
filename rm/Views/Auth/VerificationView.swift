//
//  VerificationView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit
import OTPFieldView

class VerificationView: UIView {
    
    var resendCallback: (()->())?
    
    var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let logoImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "logoWithTitle")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .H1)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        return lb
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .mainColor
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        btn.setTitleColor(.backgroundColor, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("Dowam et".localized(), for: .normal)
        return btn
    }()
    
    let phoneLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .white
//        lb.text = "+993 65 124225 belgili nomere ugradyldy"
        return lb
    }()
    
    lazy var otpField: OTPFieldView = {
        let field = OTPFieldView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.separatorSpace = 8
        field.shouldAllowIntermediateEditing = true
        field.fieldSize = 50 * KeyWords.widthRatio
        field.displayType = .roundedCorner
        field.fieldFont = UIFont(font: .H1)
        field.backgroundColor = .backgroundColor
        field.defaultBackgroundColor = .cardColor
        field.filledBackgroundColor = .cardColor
        field.fieldsCount = 5
        field.defaultBorderColor = .cardColor
        field.filledBorderColor = .cardColor
        field.requireCursor = false
        field.isHidden = true
        field.initializeUI()
        return field
    }()
    
    let timerLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Medium)
        lb.textColor = .passiveTextColor
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        DispatchQueue.main.async {
            self.otpField.initializeUI()
            self.otpField.isHidden = false
        }
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
        addSubview(scrollView)
        scrollView.addSubview(cardView)
        cardView.addSubview(logoImg)
        cardView.addSubview(descLb)
        cardView.addSubview(phoneLb)
        cardView.addSubview(confirmBtn)
        cardView.addSubview(otpField)
        cardView.addSubview(timerLb)
        cardView.addSubview(confirmBtn)
        descLb.text = "Telefon belgiňize ugradylan tassyklaýjy kody belläň".localized()
        timerLb.text = "00:59"
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickResend))
        timerLb.addGestureRecognizer(rec)
    }
    
    private func setupConstraints() {
        let layoutGuide = scrollView.contentLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: 10),
            
//            MARK: -Aslynda logo topAnchar constant 40 yone Navigation bar bolanson 20 etdim-
            logoImg.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20 * KeyWords.widthRatio),
            logoImg.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 95),
            logoImg.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -95),
            
            descLb.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 93 * KeyWords.widthRatio),
            descLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            phoneLb.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            phoneLb.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 25 * KeyWords.widthRatio),
            
            otpField.topAnchor.constraint(equalTo: phoneLb.bottomAnchor, constant: 30 * KeyWords.widthRatio),
            otpField.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            otpField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            otpField.widthAnchor.constraint(equalToConstant: 340),
            
            timerLb.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            timerLb.topAnchor.constraint(equalTo: otpField.bottomAnchor, constant: 20 * KeyWords.widthRatio),
            
            confirmBtn.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            confirmBtn.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            confirmBtn.topAnchor.constraint(equalTo: timerLb.bottomAnchor, constant: 20 * KeyWords.widthRatio),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
        ])
    }
    
    @objc func clickResend() {
        resendCallback?()
    }
    
}
