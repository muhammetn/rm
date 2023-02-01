//
//  RemoveAlertVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

protocol RemoveDelegate {
    func remove(index: Int)
}

class RemoveAlertVC: UIViewController {
    
    let mainView = RemoveAlertView()
    var delegate: RemoveDelegate?
    var index: Int
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        mainView.cancelBtn.addTarget(self, action: #selector(clickCloseBtn), for: .touchUpInside)
        mainView.removeBtn.addTarget(self, action: #selector(clickRemove), for: .touchUpInside)
    }
    
    @objc func clickCloseBtn() {
        dismiss(animated: true)
    }
    
    @objc func clickRemove() {
        dismiss(animated: true)
        delegate?.remove(index: index)
    }
    
}
