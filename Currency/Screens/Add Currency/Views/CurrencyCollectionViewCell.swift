//
//  CurrencyCollectionViewCell.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell, ReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = UIColor(named: "SelectedTextColor")
            } else {
                titleLabel.textColor = UIColor(named: "DefaultTextColor")
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
}
