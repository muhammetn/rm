//
//  CarSelectionVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation


final class CarSelectionVM {
    
    var result: Binder<[Car]> = Binder([])
    var isLoading: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    func getCarModels() {
        isLoading.value = true
//        APIDataProvider.shared.re
        APIDataProvider.shared.getCarModels { result in
            switch result {
            case .success(let success):
                self.isLoading.value = false
                self.result.value = success
            case .failure(let error):
                self.isLoading.value = false
                self.didFinishWithError.value = error
            }
        }
    }
}
