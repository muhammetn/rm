//
//  HomeView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class HomeView: UIView {
    
    let topView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let logoImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let userImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "user-1")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.separatorStyle = .none
        tb.backgroundColor = .backgroundColor
        tb.register(WasherCell.self, forCellReuseIdentifier: WasherCell.identifier)
        tb.register(VIPServiceCell.self, forCellReuseIdentifier: VIPServiceCell.identifier)
        tb.register(EditeCarCell.self, forCellReuseIdentifier: EditeCarCell.identifier)
        tb.register(TitleHeader.self, forHeaderFooterViewReuseIdentifier: TitleHeader.identifier)
        if #available(iOS 15.0, *) {
            tb.sectionHeaderTopPadding = 25
        } else { }
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(topView)
        addSubview(tableView)
        topView.addSubview(logoImageView)
        topView.addSubview(userImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            topView.heightAnchor.constraint(equalToConstant: 36 * KeyWords.widthRatio),
            
            logoImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 75),
            logoImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            
            userImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            userImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            userImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 36 * KeyWords.widthRatio),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

