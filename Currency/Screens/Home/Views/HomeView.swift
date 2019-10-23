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
            tableView.backgroundColor = UIColor(named: "backgroundColor")
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
}
