//
//  UIView.swift
//  Weather
//
//  Created by Thành Đỗ Long on 12/09/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(delay: Double = 0.0, duration: Double = 0.5) {
        alpha = 0

        UIView.animate(
            withDuration: duration,
            delay: delay,
            animations: {
                self.alpha = 1
        })
    }
}
