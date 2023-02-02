//
//  DatePickerView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 19.01.2023.
//

import UIKit

class DatePickerView: UIView {
    
    var footerCallback: (()->())?
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .backgroundColor
        return v
    }()
    
    let dateLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.text = "Выберите дату".localized()
        lb.font = UIFont(font: .S1Semibold)
        return lb
    }()
    
    let timeLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.text = "Выберите время".localized()
        lb.font = UIFont(font: .S1Semibold)
        return lb
    }()
    
    let dateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 23 * KeyWords.widthRatio
        layout.minimumInteritemSpacing = 23 * KeyWords.widthRatio
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 102 * KeyWords.widthRatio, height: 50 * KeyWords.widthRatio)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = true
        collection.alwaysBounceHorizontal = true
        collection.showsHorizontalScrollIndicator = false
        collection.allowsMultipleSelection = false
        collection.register(DateCell.self, forCellWithReuseIdentifier: DateCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .backgroundColor
        return collection
    }()
    
    let timePicker: ColoredDatePicker = {
        let picker = ColoredDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.backgroundColor = .backgroundColor
        picker.tintColor = .white
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else { }
        return picker
    }()
    
    let footerView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .mainColor
        return v
    }()
    
    let orderLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .backgroundColor
        return lb
    }()
    
    let priceLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont(font: .S1Semibold)
        lb.textColor = .backgroundColor
        return lb
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
        footerView.layer.cornerRadius = 4
    }
    
    private func setupViews() {
        backgroundColor = .backgroundColor
        addSubview(cardView)
        cardView.addSubview(dateLb)
        cardView.addSubview(dateCollectionView)
        cardView.addSubview(timeLb)
        cardView.addSubview(timePicker)
        
        addSubview(footerView)
        footerView.addSubview(orderLb)
        footerView.addSubview(priceLb)
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickFooter))
        footerView.addGestureRecognizer(rec)
        
        orderLb.text = "Заказать".localized()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            dateLb.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            dateLb.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            dateLb.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            
            dateCollectionView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            dateCollectionView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            dateCollectionView.topAnchor.constraint(equalTo: dateLb.bottomAnchor, constant: 15),
            dateCollectionView.heightAnchor.constraint(equalToConstant: 53 * KeyWords.widthRatio),
            
            timeLb.leadingAnchor.constraint(equalTo: dateLb.leadingAnchor),
            timeLb.trailingAnchor.constraint(equalTo: dateLb.trailingAnchor),
            timeLb.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor, constant: 25),
            
            timePicker.topAnchor.constraint(equalTo: timeLb.bottomAnchor, constant: 15),
            timePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            timePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            
            footerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            footerView.heightAnchor.constraint(equalToConstant: 50 * KeyWords.widthRatio),
            
            orderLb.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 25),
            orderLb.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            
            priceLb.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -25),
            priceLb.centerYAnchor.constraint(equalTo: orderLb.centerYAnchor),
        ])
    }
    
    func initPrice(price: Double) {
        let priceAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Semibold),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont(font: .S1Regular),
            NSAttributedString.Key.foregroundColor: UIColor.backgroundColor
        ]
        
        let priceStr = "\(price) TMT"
        let allPriceStr = "Итоговая цена:".localized()
        let myString = NSMutableAttributedString(string: "\(allPriceStr) \(priceStr)", attributes: attributes)
        myString.addAttributes(priceAttributes, range: NSRange(location: 15, length: priceStr.count))
        priceLb.attributedText = myString
    }
    
    @objc func clickFooter() {
        footerCallback?()
    }
    
}


class ColoredDatePicker: UIDatePicker {
    var changed = false
    override func addSubview(_ view: UIView) {
        self.setValue(UIColor.white, forKey: "textColor")
        super.addSubview(view)
    }
}
