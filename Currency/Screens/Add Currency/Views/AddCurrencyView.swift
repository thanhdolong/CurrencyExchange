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
    var searchController: UISearchController!

    var navigationItem: UINavigationItem! {
        didSet {
//            navigationItem.prompt = "Type a currency name"
            navigationItem.title = "Add"
            navigationItem.largeTitleDisplayMode = .never
        }
    }

    weak var tableView: UITableView! {
        didSet {
            tableView.keyboardDismissMode = .onDrag
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
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
        tableView.tableHeaderView = searchController.searchBar
        tableView.rowHeight = 200

        self.tableView = tableView
    }
}

extension AddCurrencyView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        view.tintColor = UIColor(named: "BackgroundColor")

        let header = view as! UITableViewHeaderFooterView
        header.layer.borderWidth = 1
        header.layer.borderColor = UIColor.clear.cgColor

        header.textLabel?.textColor = UIColor(named: "DefaultTextColor")
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.fadeTransition(delay: 0.05 * Double(indexPath.row), duration: 0.5)
    }
}
