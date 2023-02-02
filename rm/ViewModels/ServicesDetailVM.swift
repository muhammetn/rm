//
//  ServicesDetailVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

final class ServicesDetailVM {
    
    var washer: Washer
    
    var servicePackages: Binder<[ServicePackage]> = Binder([])
    var services: Binder<[Service]> = Binder([])
    var didFinish: Binder<Bool> = Binder(false)
    var isLoading: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    init(washer: Washer) {
        self.washer = washer
    }
    
    func getServices() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        isLoading.value = true
        APIDataProvider.shared.getServicePackage { result in
            print(result)
            switch result {
            case .success(let success):
//                self.isLoading.value = false
                self.servicePackages.value = success
            case .failure(let error):
//                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
            group.leave()
        }
        
        APIDataProvider.shared.getService(type: "normal") { result in
            print(result)
            switch result {
            case .success(let success):
                self.services.value = success
            case .failure(let error):
                self.didFinishWithError.value = error
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.isLoading.value = false
            self.didFinish.value = true
        }
    }
}
