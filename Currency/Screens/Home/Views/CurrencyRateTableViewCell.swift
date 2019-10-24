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
                currencyLabel.textColor = UIColor(named: "SelectedTextColor")
            } else {
                currencyLabel.textColor = UIColor(named: "DefaultTextColor")
            }
        }
    }

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
}
