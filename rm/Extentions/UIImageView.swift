//
//  UIImageView.swift
//  rm
//
//  Created by Muhammet Nurchayev on 24.01.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func sdImageLoad(imgUrl: String?) {
        guard let imgUrl = imgUrl else { return }
        self.sd_imageTransition = .fade
        let strUrl = imgUrl
        self.sd_setImage(with: URL(string: strUrl), placeholderImage: #imageLiteral(resourceName: "image"), options: .waitStoreCache) { image, _, _, _ in }
    }
}
