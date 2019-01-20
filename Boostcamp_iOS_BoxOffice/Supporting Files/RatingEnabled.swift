//
//  RatingEnabled.swift
//  Boostcamp_iOS_BoxOffice
//
//  Created by zun on 20/01/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import UIKit

protocol RatingEnabled {
    func setUserRating(_ rating: Double, to stackView: UIStackView)
}

extension RatingEnabled {
    func setUserRating(_ rating: Double, to stackView: UIStackView) {
        var index: Int = 0
        var value: Double = 2
        while true {
            if rating >= value {
                if let imageView = stackView.arrangedSubviews[index] as? UIImageView {
                    imageView.image = UIImage(named: "ic_star_large_full")
                }
                value = value + 2
                index = index + 1
            } else {
                value = value - 1
                if rating >= value {
                    if let imageView = stackView.arrangedSubviews[index] as? UIImageView {
                        imageView.image = UIImage(named: "ic_star_large_half")
                    }
                    return
                } else {
                    return
                }
            }
        }
    }
}
