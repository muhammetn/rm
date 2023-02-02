//
//  StatusVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 31.01.2023.
//

import Foundation

final class StatusVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<[Order]?> = Binder(nil)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    var doneOrders: [Order] = []
    var onProcess: [Order] = []
    var orders = [Order]()
    var load = true
    
    func getOrders(page: Int) {
        if !load { return }
        isLoading.value = true
        APIDataProvider.shared.getOrders(page: page) { results in
            switch results {
            case .success(let orders):
                if orders.count < 20 {
                    self.load = false
                }
                self.orders.append(contentsOf: orders)
                self.isLoading.value = false
                self.didFinish.value = orders
            case .failure(let error):
                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
        }
    }
}
