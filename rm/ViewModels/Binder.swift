//
//  Binder.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import Foundation

class Binder<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            fireListenerOnMainThread()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        fireListenerOnMainThread()
    }
    
    private func fireListenerOnMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
            let gListener = self.listener else { return }
            gListener(self.value)
        }
    }
}
