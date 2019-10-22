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
}

class CurrencyRateTableViewCell: UITableViewCell, CurrencyRateCell, ReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
}
