//
//  HomeViewController.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import Alamofire

protocol HomeViewControllerDelegate: class {
  func homeViewControllerDidPressAddCurrency(_ viewController: HomeViewController)
}

class HomeViewController: UIViewController {
    let searchController: UISearchController
    var homeViewModel: HomeViewModel
    var homeView: HomeView! { return (view as! HomeView) }
    weak var delegate: HomeViewControllerDelegate?

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)

        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Currency Rates")
        return refreshControl
    }()

    @objc func refresh(_ sender: UIRefreshControl) {
        self.homeViewModel.downloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        setupNavigationController()
        setupSearchController()
        registerCellForReuse()
    }

    init(homeViewModel: HomeViewModel,
         searchController: UISearchController = UISearchController(searchResultsController: nil)) {
        self.homeViewModel = homeViewModel
        self.searchController = searchController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
    }

    private func setupViewModel() {
        homeView.indicator = showActivityIndicatory(onView: self.view)
        homeView.tableView.addSubview(refreshControl)

        homeViewModel.delegate = self
        homeViewModel.downloadData()
    }

    @objc func addCurrencyTapped(sender: UIBarButtonItem) {
        delegate?.homeViewControllerDidPressAddCurrency(self)
    }

    private func setupNavigationController() {
        let plusCircle = UIImage(systemName: "plus.circle.fill")

        let navigationBar = navigationController?.navigationBar
        navigationBar?.prefersLargeTitles = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: plusCircle, style: .plain, target: self, action: #selector(addCurrencyTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "SecondaryColor")
        navigationItem.title = "Currency"

        navigationItem.searchController = searchController
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }

    private func registerCellForReuse() {
        homeView.tableView.register(CurrencyRateTableViewCell.nib, forCellReuseIdentifier: CurrencyRateTableViewCell.reuseIdentifier)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeView.tableView.dequeueReusableCell(withIdentifier: CurrencyRateTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyRateTableViewCell else {
            return self.tableView(tableView, cellForRowAt: indexPath)
        }

        homeViewModel.configureCell(cell, for: indexPath)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        homeViewModel.setBaseCurrency(for: indexPath)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didRecieveDataUpdate() {
        refreshControl.endRefreshing()
        removeIndicator(indicator: homeView.indicator)
        homeView.tableView.reloadData()
    }

    func didRecieveError(error: String?) {
        presentAlertAction(withTitle: "Something went wrong", message: error)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        homeViewModel.query = searchBar.text
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        homeViewModel.query = nil
    }
}
