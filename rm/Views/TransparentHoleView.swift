//
//  TransparentHoleView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 20.01.2023.
//

import UIKit

class TransparentHoleView: UIView {
    
    var roundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor?.setFill()
        UIRectFill(rect)
        let layer = CAShapeLayer()
        let path = CGMutablePath()
        path.addEllipse(in: roundView.frame)
        path.addRect(bounds)
        layer.path = path
        layer.fillRule = CAShapeLayerFillRule.evenOdd
        self.layer.mask = layer
        self.layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(roundView)
        
        NSLayoutConstraint.activate([
            roundView.heightAnchor.constraint(equalToConstant: 80 * KeyWords.widthRatio),
            roundView.widthAnchor.constraint(equalToConstant: 80 * KeyWords.widthRatio),
            roundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundView.centerYAnchor.constraint(equalTo: topAnchor),
        ])
        roundView.layer.cornerRadius = 40
    }
}
