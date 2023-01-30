//
//  VerificationVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation


final class VerificationVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var loadWithError: Binder<NetworkError?> = Binder(nil)
    var didSign: Binder<User?> = Binder(nil)
    
    func signUser(phone: String, code: String) {
        isLoading.value = true
        APIDataProvider.shared.signUser(phone: phone, code: code) { result in
            switch result {
            case .success(let user):
                self.isLoading.value = false
                self.didSign.value = user
            case .failure(let failure):
                self.isLoading.value = false
                self.loadWithError.value = failure
            }
        }
        
    }
    
}
