//
//  ProfileViewModel.swift
//  rm
//
//  Created by Muhammet Nurchayev on 01/02/2023.
//

import Foundation

final class ProfileVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var loaded: Binder<User?> = Binder(nil)
    var loadedWithError: Binder<NetworkError?> = Binder(nil)
    
    func loadUser() {
        isLoading.value = true
        APIDataProvider.shared.getUser { result in
            self.isLoading.value = false
            switch result {
            case .success(let user):
                self.loaded.value = user
            case .failure(let error):
                self.loadedWithError.value = error
            }
        }
    }
}
