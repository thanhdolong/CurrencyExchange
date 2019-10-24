//
//  HomeView.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class HomeView: UIView {
    var indicator: UIView?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor(named: "BackgroundColor")
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.keyboardDismissMode = .onDrag
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
