//
//  UITableView.swift
//  Currency
//
//  Created by Thành Đỗ Long on 25/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyMessageIfNeeded(numberOfRowsInSection: Int, _ message: String) {
        guard numberOfRowsInSection == 0 else {
            setEmptyBackgroundView()
            return
        }

        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func setNoReachableMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = "The Internet connection appears to be offline. We cannot load currency exchange rate.\n\nPlease use pull-to-refresh to reload data. 😊"
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    private func setEmptyBackgroundView() {
        self.backgroundView = nil
    }
}
