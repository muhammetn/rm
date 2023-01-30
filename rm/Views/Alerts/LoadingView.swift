//
//  LoadingView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import UIKit

class LoadingView: UIView {
    
    let loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .whiteLarge
        }
        indicator.color = .white
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        return blurEffectView
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
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )
        addSubview(loadingActivityIndicator)
    }
    
    private func setupConstraints() {
        
    }
}
