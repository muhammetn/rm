//
//  RemoveAlertVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 18.01.2023.
//

import UIKit

class RemoveAlertVC: UIViewController {
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
