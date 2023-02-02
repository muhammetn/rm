//
//  ErrorView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import UIKit

class NetworkErrorView: UIView {
    
    var callBack: (()->())?
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = .passiveTextColor
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "no_internet")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let stackView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.distribution = .fillEqually
        v.axis = .vertical
        v.spacing = 15
        return v
    }()
    
    let titleLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont(font: .H2)
        return lb
    }()
    
    let descLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.textColor = .white
        lb.font = UIFont(font: .B1Regular)
        return lb
    }()
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .mainColor
        btn.titleLabel?.textAlignment = .center
        btn.setTitle("Повторить попытку".localized(), for: .normal)
        btn.titleLabel?.font = UIFont(font: .S1Semibold)
        btn.setTitleColor(.cardColor, for: .normal)
        return btn
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
        button.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(imageView)
        addSubview(stackView)
        addSubview(button)
        stackView.addArrangedSubview(titleLb)
        stackView.addArrangedSubview(descLb)
        
        titleLb.text = "Отсутствует интернет-соединение. ".localized()
        
        descLb.text = "Проверьте подключение к WI-FI или сотовой сети и повторите попытку."
        
        button.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100 * KeyWords.widthRatio),
            imageView.widthAnchor.constraint(equalToConstant: 100 * KeyWords.widthRatio),
            
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
        ])
    }
    
    @objc func clickBtn() {
        callBack?()
    }
    
}
