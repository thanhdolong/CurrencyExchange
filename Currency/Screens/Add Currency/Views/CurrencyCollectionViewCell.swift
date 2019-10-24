//
//  CurrencyCollectionViewCell.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell, ReusableView {
    var isCurrencySelected: Bool? {
        didSet {
            guard let isActive = isCurrencySelected else { return }
            if isActive {
                let selectedColor = UIColor(named: "SelectedTextColor")
                bgView.backgroundColor = UIColor(named: "SelectedBgColor")
                titleLabel.textColor = selectedColor
                subtitleLabel.textColor = selectedColor
            } else {
                let defaultColor = UIColor(named: "DefaultTextColor")
                bgView.backgroundColor = UIColor(named: "SecondaryBgColor")
                titleLabel.textColor = defaultColor
                subtitleLabel.textColor = defaultColor
            }
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 30
        }
    }

}
