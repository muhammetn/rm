//
//  ChangePhoneView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import UIKit

final class ChangePhoneVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var loadWithError: Binder<NetworkError?> = Binder(nil)
    var didStartVerification: Binder<String?> = Binder(nil)
    
    func startVer(phone: String) {
        isLoading.value = true
        let phoneNumber = "+993\(phone.removingWhitespaces())"
        APIDataProvider.shared.startVerification(phone: phoneNumber, withAuth: true) { result in
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
