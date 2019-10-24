//
//  AddCurrencyViewController.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class AddCurrencyViewController: UIViewController {
    var addCurrencViewModel: AddCurrencyViewModel
    var addCurrencView: AddCurrencyView! { return (view as! AddCurrencyView) }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        setupSearchController()
    }

    override func loadView() {
        let addCurrencView = AddCurrencyView()
        view = addCurrencView
    }

    init(addCurrencViewModel: AddCurrencyViewModel) {
        self.addCurrencViewModel = addCurrencViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addCurrencView.tableView.dataSource = self
        addCurrencView.tableView.register(GroupOfCurrenciesTableViewCell.self, forCellReuseIdentifier: GroupOfCurrenciesTableViewCell.reuseIdentifier)
        addCurrencView.navigationItem = navigationItem
    }

    private func setupViewModel() {
        addCurrencViewModel.delegate = self
        addCurrencViewModel.downloadData()
    }

    private func setupSearchController() {
        addCurrencView.searchController.searchResultsUpdater = self
        addCurrencView.searchController.searchBar.delegate = self
    }
}

extension AddCurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return addCurrencViewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addCurrencViewModel.getKeyFrom(section)
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return addCurrencViewModel.getAllKeys()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = addCurrencView.tableView.dequeueReusableCell(withIdentifier: GroupOfCurrenciesTableViewCell.reuseIdentifier, for: indexPath) as? GroupOfCurrenciesTableViewCell else {
            return self.tableView(tableView, cellForRowAt: indexPath)
        }

        cell.items = addCurrencViewModel.getValues(from: indexPath.section)
        return cell
    }
}

extension AddCurrencyViewController: AddCurrencyViewModelDelegate {
    func didRecieveDataUpdate() {
        addCurrencView.tableView.reloadData()
    }

    func didRecieveError(error: String?) {
        presentAlertAction(withTitle: "Something went wrong", message: error)
    }
}

extension AddCurrencyViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        addCurrencViewModel.query = searchBar.text
    }
}

extension AddCurrencyViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        addCurrencViewModel.query = nil
    }
}
