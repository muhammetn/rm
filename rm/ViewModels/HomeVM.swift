//
//  HomeVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

final class HomeVM {
    
    var washers: Binder<[Washer]> = Binder([])
    var isLoading: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    func getWashers() {
        isLoading.value = true
        APIDataProvider.shared.getWasher { result in
            switch result {
            case .success(let success):
                self.isLoading.value = false
                self.washers.value = success
            case .failure(let error):
                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
        }
    }
}
