//
//  DatePickerVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 19.01.2023.
//

import UIKit

class DatePickerVC: UIViewController {
    
    let mainView = DatePickerView()
    lazy var success = Helper.getAlert(SuccessVC())
    
    override func loadView() {
        super.loadView()
        view = mainView
        mainView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        mainView.dateCollectionView.delegate   = self
        mainView.dateCollectionView.dataSource = self
        mainView.footerCallback = { [weak self] in
            guard let self = self else {
                return
            }
            self.present(self.success, animated: true)
        }
    }
    
    
}


extension DatePickerVC: UICollectionViewDelegate {
    
}

extension DatePickerVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        return cell
    }
    
}


//extension DatePickerVC: UICollectionViewDelegateFlowLayout {
//
//}
