//
//  SelectedServicesListVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 30.01.2023.
//

import Foundation

final class SelectedServicesListVM {
    
    var services: [Service]
    var timeSelection: WashTime = .now
    var carNo = String()
    var carModel = String()
    var washer: Washer
    lazy var rowCount = services.count + 2
    
    var didStartLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    init(services: [Service], washer: Washer) {
        self.services = services
        self.washer = washer
    }
    
    func createOrder() {
        self.didStartLoading.value = true
        let stringArray = services.map { String($0.service_id ?? 0) }
        let joinedStr = stringArray.joined(separator: ",")
        APIDataProvider.shared.createOrder(services: "\(joinedStr)", car_model: AuthHelper.shared.car ?? -1, car_no: carNo, car_type: carModel, is_booked: false, book_time: Date().toString(), washer_id: washer.washer_id ?? 0, washer_count: 0) { result in
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
