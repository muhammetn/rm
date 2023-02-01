//
//  PackageServiceVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 30.01.2023.
//

import Foundation


final class PackageServiceVM {
    
//    MARK: -Properties
    var carModel = String()
    var carNo = String()
    var timeSelection: WashTime = .now
    var package: ServicePackage
    var washer: Washer
    
//    MARK: -Binders
    var didStartLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
//    MARK: - init
    init(package: ServicePackage, washer: Washer) {
        self.package = package
        self.washer = washer
    }
    
    func createOrder() {
        self.didStartLoading.value = true
        APIDataProvider.shared.createOrder(package: package.sp_id ?? 0 , car_model: AuthHelper.shared.car ?? -1, car_no: carNo, car_type: carModel, is_booked: false, book_time: Date().toString(), washer_id: washer.washer_id ?? 0, washer_count: 1) { result in
            switch result {
            case .success(let success):
                self.didStartLoading.value = false
                self.didFinish.value = true
                print(success)
            case .failure(let error):
                self.didStartLoading.value = false
                self.didFinishWithError.value = error
                print("error: \(error)")
            }
        }
    }
    
//    MARK: -Helper functions
    
    
}
