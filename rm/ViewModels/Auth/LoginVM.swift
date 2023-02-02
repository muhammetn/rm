//
//  LoginVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 25.01.2023.
//

import Foundation

final class LoginVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var loadWithError: Binder<NetworkError?> = Binder(nil)
    var didStartVerification: Binder<String?> = Binder(nil)
    var isChecked: Bool = false
    
    func startVer(phone: String) {
        isLoading.value = true
        let phoneNumber = "+993\(phone.removingWhitespaces())"
        APIDataProvider.shared.startVerification(phone: phoneNumber) { result in
            switch result {
            case .success(_):
                self.isLoading.value = false
                self.didStartVerification.value = phoneNumber
            case .failure(let failure):
                self.isLoading.value = false
                self.loadWithError.value = failure
            }
        }
    }
    
}
