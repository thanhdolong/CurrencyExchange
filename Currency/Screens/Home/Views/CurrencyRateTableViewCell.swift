//
//  CurrencyRateTableViewCell.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

protocol CurrencyRateCell: class {
    var flagImage: UIImageView! { get }
    var currencyLabel: UILabel! { get }
    var rateLabel: UILabel! { get }
    var symbolLabel: UILabel! { get }
    var isSelected: Bool { get set }
}

class CurrencyRateTableViewCell: UITableViewCell, CurrencyRateCell, ReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                let selectedColor = UIColor(named: "SelectedTextColor")
                bgView.backgroundColor = UIColor(named: "SelectedBgColor")
                currencyLabel.textColor = selectedColor
                rateLabel.textColor = selectedColor
                symbolLabel.textColor = selectedColor
            } else {
                let defaultColor = UIColor(named: "DefaultTextColor")
                bgView.backgroundColor = UIColor(named: "SecondaryBgColor")
                currencyLabel.textColor = defaultColor
                rateLabel.textColor = defaultColor
                symbolLabel.textColor = defaultColor
            }
        }
    }

    @IBOutlet weak var flagImage: UIImageView! {
        didSet {
            flagImage.makeRounded()
        }
    }
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 30
        }
    }
}
