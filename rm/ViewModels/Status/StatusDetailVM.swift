//
//  StatusDetailVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import Foundation

final class StatusDetailVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<Order?> = Binder(nil)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    var orderId: Int
    var orderDetail: Order?
    
    init(orderId: Int) {
        self.orderId = orderId
    }
    
    func getStatusDetail() {
        isLoading.value = true
        APIDataProvider.shared.getOrderDetail(order_id: orderId) { result in
            switch result {
            case .success(let order):
                self.isLoading.value = false
                self.didFinish.value = order
            case .failure(let error):
                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
        }
    }
}
