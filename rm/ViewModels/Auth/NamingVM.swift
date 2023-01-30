//
//  NamingVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

final class NamingVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var loadWithError: Binder<NetworkError?> = Binder(nil)
    var didFinish: Binder<Bool> = Binder(false)
    
    func setUsername(username: String) {
        isLoading.value = true
        APIDataProvider.shared.setUserame(username: username) { result in
            switch result {
            case .success(_):
                self.isLoading.value = false
                self.didFinish.value = true
            case .failure(let failure):
                self.isLoading.value = false
                self.loadWithError.value = failure
            }
        }
    }
    
}
