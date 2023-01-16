//
//  CarSelectionVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class CarSelectionVC: UIViewController {
    
    let mainView = CarSelectionView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}


extension CarSelectionVC: UICollectionViewDelegate {
    
}

extension CarSelectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarSelectionCell.identifier, for: indexPath) as! CarSelectionCell
        return cell
    }
    
    
}
