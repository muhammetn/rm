//
//  VIPPackageServiceVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 28.01.2023.
//

import Foundation

final class VIPPackageServiceVM {
    
//    MARK: -Properties
    var service: Service
    
    var didStartLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    init(service: Service) {
        self.service = service
    }
    
    func createOrder(carNo: String, carType: String) {
        self.didStartLoading.value = true
        APIDataProvider.shared.createOrder(services: "\(service.service_id ?? 0)", car_model: AuthHelper.shared.car ?? -1, car_no: carNo, car_type: carType, is_booked: false, book_time: Date().toString(), washer_id: 0, washer_count: 0) { result in
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
    
    
}
