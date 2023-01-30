//
//  VIPServicesListVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

final class VIPServicesListVM {
    
    var services: Binder<[Service]> = Binder([])
    var isLoading: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    
    func getServices() {
        isLoading.value = true
        APIDataProvider.shared.getService(type: "vip") { result in
            switch result {
            case .success(let success):
                self.isLoading.value = false
                self.services.value = success
            case .failure(let error):
                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
        }
    }
    
}
