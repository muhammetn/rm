//
//  ServicesVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 16.01.2023.
//

import UIKit

class ServicesVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.backgroundColor = .backgroundColor
        label.textColor = .passiveTextColor
        label.text = "Test heredsads"
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
    }
    
}
