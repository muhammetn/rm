//
//  DatePickerVC.swift
//  rm
//
//  Created by Muhammet Nurchayev on 19.01.2023.
//

import UIKit

class DatePickerVC: UIViewController {
    
    let mainView = DatePickerView()
    var viewModel: DatePickerVM?
    
    lazy var loadingView = LoadingView()
    lazy var networkErrorView = NetworkErrorView()
    
    init(services: [Service], carNo: String, carType: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = DatePickerVM(services: services, carNo: carNo, carType: carType)
    }
    
    init(package: ServicePackage, carNo: String, carType: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = DatePickerVM(package: package, carNo: carNo, carType: carType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
        mainView.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode   = .never
        mainView.dateCollectionView.delegate   = self
        mainView.dateCollectionView.dataSource = self
        let packagePrice = viewModel?.package.getPrice()
        var servicesPrice = Double()
        viewModel?.services.forEach({servicesPrice += $0.getPrice()})
        mainView.initPrice(price: (packagePrice ?? 0) + servicesPrice)
        mainView.footerCallback = { [weak self] in
            guard let self = self else {
                return
            }
            guard let date = self.viewModel?.selectedDate else {
                self.presentErrorAlert(title: "warning", msg: "please select date!")
                return
            }
            let today = Date().toString(dateFormat: "HH:mm")
            let time = self.mainView.timePicker.date.toString(dateFormat: "HH:mm")
            let todayDate = today.toDate()
            let timeDate = time.toDate()
            let timeEqual = todayDate.time <= timeDate.time
            if !timeEqual && (self.viewModel?.selectedIndex ?? 0) == 0 {
                self.presentErrorAlert(title: "warning", msg: "please select correct!")
                return
            }
            self.viewModel?.createOrder(date: "\(date) \(time)")
        }
    }
    
    private func bindViewModel() {
        viewModel?.didStartLoading.bind { [weak self] isEnabled in
            guard let self = self else { return }
            if isEnabled {
                self.view.addSubview(self.loadingView)
                self.loadingView.frame = self.view.bounds
            }
        }
        
        viewModel?.didFinishWithError.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            print("error \(error.customDescription)")
            self.loadingView.removeFromSuperview()
            switch error {
            case .noInternet:
                self.view = self.networkErrorView
            default:
                self.presentErrorAlert(msg: error.customDescription)
            }
        }
        viewModel?.didFinish.bind({ [weak self] value in
            guard let self = self else { return }
            if value {
                print("success")
                self.loadingView.removeFromSuperview()
                let vc = Helper.getAlert(SuccessVC())
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.present(vc, animated: true)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        })
    }
    
}

extension DatePickerVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.selectedIndex = indexPath.row
        viewModel.selectedDate = viewModel.dates[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.months.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        cell.initDate(day: viewModel.days[indexPath.row], month: viewModel.months[indexPath.row], dayName: viewModel.dayNames[indexPath.row])
        return cell
    }
    
}

