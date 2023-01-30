//
//  CarSelectionVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 17.01.2023.
//

import UIKit

class CarSelectionVC: UIViewController {
    
    let mainView = CarSelectionView()
    var viewModel = CarSelectionVM()
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.confirmBtn.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
        networkErrorView.button.addTarget(self, action: #selector(clickReload), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        
        viewModel.didFinishWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print("error \(error.customDescription)")
            self.loadingView.removeFromSuperview()
            switch error {
            case .networkError:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        
        viewModel.result.bind { [weak self] cars in
            guard let self = self else { return }
            self.loadingView.removeFromSuperview()
            self.mainView.collectionView.reloadData()
        }
        viewModel.getCarModels()
    }
    
    @objc func clickConfirm() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let tabbar = TabBarController()
        tabbar.selectedIndex = 0
        window.rootViewController = tabbar
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {
        }, completion: { completed in })
    }
    
    @objc func clickReload() {
        view = mainView
        viewModel.getCarModels()
    }
    
}


extension CarSelectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AuthHelper.shared.car = viewModel.result.value[indexPath.row].model_id
        AuthHelper.shared.carNameRu = viewModel.result.value[indexPath.row].title_ru
        AuthHelper.shared.carNameTm = viewModel.result.value[indexPath.row].title
        mainView.confirmBtn.backgroundColor = .mainColor
        mainView.confirmBtn.isEnabled = true
    }
}

extension CarSelectionVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.result.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarSelectionCell.identifier, for: indexPath) as! CarSelectionCell
        let selected = AuthHelper.shared.car ?? -1
        cell.initData(viewModel.result.value[indexPath.row])
        if selected == viewModel.result.value[indexPath.row].model_id ?? 0 {
            mainView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            mainView.confirmBtn.backgroundColor = .mainColor
            mainView.confirmBtn.isEnabled = true
        }
        return cell
    }
    
}
