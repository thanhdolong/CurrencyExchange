//
//  AddCurrencyViewController.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class AddCurrencyViewController: UIViewController {
    let searchController: UISearchController
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
    
    init(addCurrencViewModel: AddCurrencyViewModel,
         searchController: UISearchController = UISearchController(searchResultsController: nil)) {
        self.addCurrencViewModel = addCurrencViewModel
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
        
        self.setupNavigationController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addCurrencView.tableView.dataSource = self
        addCurrencView.tableView.register(GroupOfCurrenciesTableViewCell.self, forCellReuseIdentifier: GroupOfCurrenciesTableViewCell.reuseIdentifier)
    }
    
    private func setupNavigationController() {
        navigationItem.prompt = "Type a currency name"
        navigationItem.title = "Add"
        navigationItem.searchController = searchController
    }
    
    private func setupViewModel() {
        addCurrencViewModel.delegate = self
        addCurrencViewModel.downloadData()
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
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
        cell.awakeFromNib()
        return cell
    }
}


extension AddCurrencyViewController: AddCurrencyViewModelDelegate {
    func didRecieveDataUpdate() {
        print(addCurrencViewModel.data)
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
