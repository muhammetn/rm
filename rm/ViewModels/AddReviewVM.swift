//
//  AddReviewVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 02/02/2023.
//

import Foundation

final class AddReviewVM {
    
    var isLoading: Binder<Bool> = Binder(false)
    var didLoad: Binder<Bool> = Binder(false)
    var didLoadWithError: Binder<NetworkError?> = Binder(nil)
    var rating: Int = 3
    var review = String()
    var orderId: Int
    
    init(orderId: Int) {
        self.orderId = orderId
    }
    
    func addReview() {
        isLoading.value = true
        APIDataProvider.shared.addReview(rating: rating, review: review, orderId: orderId) { result in
            self.isLoading.value = false
            switch result {
            case .success(_):
                self.didLoad.value = true
            case .failure(let error):
                self.didLoadWithError.value = error
            }
        }
    }
}
