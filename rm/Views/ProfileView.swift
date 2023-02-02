//
//  ProfileView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit

class ProfileView: UIView {
    
    var ruLangCallback: (()->())?
    var tkLangCallback: (()->())?
    
    var nameCallback: (()->())?
    var phoneCallback: (()->())?
    
    var logOutCallback: (()->())?
    var removeAccountCallback: (()->())?
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let bottomLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B3)
        lb.text = "Powered by Pikir"
        return lb
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Профил и настройки".localized()
        lb.font = UIFont(font: .H1)
        lb.textColor = .white
        return lb
    }()
    
    let nameField: CustomTextField = {
        let field = CustomTextField(padding: UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(font: .B1Regular)
        field.backgroundColor = .cardColor
        field.isEnabled = false
        field.isUserInteractionEnabled = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Имя:".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor]
        )
        return field
    }()
    
    let phoneField: CustomTextField = {
        let field = CustomTextField(padding: UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont(font: .B1Regular)
        field.backgroundColor = .cardColor
        field.isEnabled = false
        field.isUserInteractionEnabled = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Телефон:".localized(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.passiveTextColor]
        )
        return field
    }()
    
    let langLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Язык:".localized()
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .white
        return lb
    }()
    
    let tkLangView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let ruLangView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let tkLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.textColor = .white
        lb.text = "Türkmen Dili".localized()
        return lb
    }()
    
    let ruLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .B1Regular)
        lb.text = "Русский".localized()
        lb.textColor = .white
        return lb
    }()
    
    let ruIconImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Radio=Active")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let tkIconImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Radio=Passive")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let usernameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.isUserInteractionEnabled = true
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let phoneLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.isUserInteractionEnabled = true
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let removeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cardColor
        return v
    }()
    
    let removeStackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.spacing = 10
        v.axis = .horizontal
        return v
    }()
    
    let removeLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(font: .B1Regular)
        lb.text = "Удалить аккаунт".localized()
        lb.textColor = .redColorr
        return lb
    }()
    
    let removeIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .redColorr
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "Trash")
        return img
    }()
    
    let logoutView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.cgColor
        v.backgroundColor = .cardColor
        return v
    }()
    
    let logoutStackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.spacing = 10
        v.axis = .horizontal
        return v
    }()
    
    let logoutLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(font: .B1Regular)
        lb.text = "Выйти из аккаунта".localized()
        lb.textColor = .white
        return lb
    }()
    
    let logoutIconImg: UIImageView = {
        let img = UIImageView()
        img.tintColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "log-out")
        return img
    }()
    
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
        tkLangView.layer.cornerRadius = 4
        ruLangView.layer.cornerRadius = 4
        phoneField.layer.cornerRadius = 4
        nameField.layer.cornerRadius  = 4
        removeView.layer.cornerRadius = 4
        logoutView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(cardView)
        cardView.addSubview(phoneField)
        cardView.addSubview(nameField)
        cardView.addSubview(langLb)
        cardView.addSubview(tkLangView)
        cardView.addSubview(ruLangView)
        tkLangView.addSubview(tkLb)
        tkLangView.addSubview(tkIconImg)
        ruLangView.addSubview(ruLb)
        ruLangView.addSubview(ruIconImg)
        cardView.addSubview(usernameLb)
        cardView.addSubview(phoneLb)
        cardView.addSubview(bottomLb)
        
        cardView.addSubview(logoutView)
        cardView.addSubview(removeView)
        
        removeView.addSubview(removeStackView)
        removeStackView.addArrangedSubview(removeIconImg)
        removeStackView.addArrangedSubview(removeLb)
        
        logoutView.addSubview(logoutStackView)
        logoutStackView.addArrangedSubview(logoutIconImg)
        logoutStackView.addArrangedSubview(logoutLb)
        
        let ruRec = UITapGestureRecognizer(target: self, action: #selector(clickRu))
        let tkRec = UITapGestureRecognizer(target: self, action: #selector(clickTk))
        
        tkLangView.addGestureRecognizer(tkRec)
        ruLangView.addGestureRecognizer(ruRec)
        let lang = AppLanguage.currentAppleLanguage()
        print(lang)
        if lang == "ru" {
            ruIconImg.image = UIImage(named: "Radio=Active")
            tkIconImg.image = UIImage(named: "Radio=Passive")
        } else {
            ruIconImg.image = UIImage(named: "Radio=Passive")
            tkIconImg.image = UIImage(named: "Radio=Active")
        }
        
        let nameRec  = UITapGestureRecognizer(target: self, action: #selector(clickName))
        let phoneRec = UITapGestureRecognizer(target: self, action: #selector(clickPhone))
        
        usernameLb.addGestureRecognizer(nameRec)
        phoneLb.addGestureRecognizer(phoneRec)
        
        let logOutRec = UITapGestureRecognizer(target: self, action: #selector(clickLogout))
        let removeRec = UITapGestureRecognizer(target: self, action: #selector(clickRemove))
        logoutView.addGestureRecognizer(logOutRec)
        removeView.addGestureRecognizer(removeRec)
    }
    
    private func setupConstraints() {
        let layoutGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            layoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            layoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            
            nameField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            nameField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            nameField.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            phoneField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            phoneField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            phoneField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            phoneField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            langLb.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            langLb.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 25),
            
            tkLangView.topAnchor.constraint(equalTo: langLb.bottomAnchor, constant: 15),
            tkLangView.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            tkLangView.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            tkLangView.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            tkIconImg.leadingAnchor.constraint(equalTo: tkLangView.leadingAnchor, constant: 16),
            tkIconImg.centerYAnchor.constraint(equalTo: tkLangView.centerYAnchor),
            tkIconImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            tkIconImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            tkLb.leadingAnchor.constraint(equalTo: tkIconImg.trailingAnchor, constant: 10),
            tkLb.centerYAnchor.constraint(equalTo: tkIconImg.centerYAnchor),
            
            ruLangView.topAnchor.constraint(equalTo: tkLangView.bottomAnchor, constant: 15),
            ruLangView.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            ruLangView.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            ruLangView.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            ruIconImg.leadingAnchor.constraint(equalTo: ruLangView.leadingAnchor, constant: 16),
            ruIconImg.centerYAnchor.constraint(equalTo: ruLangView.centerYAnchor),
            ruIconImg.heightAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            ruIconImg.widthAnchor.constraint(equalToConstant: 20 * KeyWords.widthRatio),
            
            ruLb.leadingAnchor.constraint(equalTo: ruIconImg.trailingAnchor, constant: 10),
            ruLb.centerYAnchor.constraint(equalTo: ruIconImg.centerYAnchor),
            
            usernameLb.trailingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: -16),
            usernameLb.centerYAnchor.constraint(equalTo: nameField.centerYAnchor),
            
            phoneLb.trailingAnchor.constraint(equalTo: phoneField.trailingAnchor, constant: -16),
            phoneLb.centerYAnchor.constraint(equalTo: phoneField.centerYAnchor),
            
            logoutView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            logoutView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            logoutView.topAnchor.constraint(equalTo: ruLangView.bottomAnchor, constant: 110),
            logoutView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            logoutStackView.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutStackView.centerXAnchor.constraint(equalTo: logoutView.centerXAnchor),
            
            removeView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            removeView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            removeView.topAnchor.constraint(equalTo: logoutView.bottomAnchor, constant: 15),
            removeView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            removeStackView.centerXAnchor.constraint(equalTo: removeView.centerXAnchor),
            removeStackView.centerYAnchor.constraint(equalTo: removeView.centerYAnchor),
            
            bottomLb.topAnchor.constraint(equalTo: removeView.bottomAnchor, constant: 103),
            bottomLb.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            bottomLb.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
        ])
    }
    
    @objc func clickRu() {
        AppLanguage.setAppleLanguageTo(lang: "ru")
        UIApplication.shared.keyWindow?.rootViewController = TabBarController()
    }
    
    @objc func clickTk() {
        AppLanguage.setAppleLanguageTo(lang: "tk")
        UIApplication.shared.keyWindow?.rootViewController = TabBarController()
    }
    
    @objc func clickName() {
        nameCallback?()
    }
    
    @objc func clickPhone() {
        phoneCallback?()
    }
    
    @objc func clickLogout() {
        logOutCallback?()
    }
    
    @objc func clickRemove() {
        removeAccountCallback?()
    }
}

