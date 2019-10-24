//
//  AddCurrencyView.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import SnapKit

class AddCurrencyView: UIView {
    var searchController: UISearchController! {
        didSet {
            searchController.obscuresBackgroundDuringPresentation = true
            searchController.searchBar.placeholder = "Search"
        }
    }

    var navigationItem: UINavigationItem! {
        didSet {
//            navigationItem.prompt = "Type a currency name"
            navigationItem.title = "Add"
            navigationItem.searchController = searchController
            navigationItem.largeTitleDisplayMode = .never
        }
    }

    weak var tableView: UITableView! {
        didSet {
            tableView.keyboardDismissMode = .onDrag
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        searchController = UISearchController(searchResultsController: nil)
        self.backgroundColor = UIColor(named: "BackgroundColor")
        createSubviews()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func createSubviews() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp_topMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        tableView.backgroundColor = UIColor(named: "BackgroundColor")
        tableView.rowHeight = 200

        self.tableView = tableView
    }
}
