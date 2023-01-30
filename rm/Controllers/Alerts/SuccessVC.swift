//
//  SuccessVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 19.01.2023.
//

import UIKit

class SuccessVC: UIViewController {
    
    let mainView = SuccessView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        mainView.button.addTarget(self, action: #selector(clickCloseBtn), for: .touchUpInside)
    }
    
    @objc func clickCloseBtn() {
        dismiss(animated: true)
    }
    
}

