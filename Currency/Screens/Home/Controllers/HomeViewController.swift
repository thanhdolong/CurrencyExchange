//
//  HomeViewController.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModel
    var homeView: HomeView! { return (view as! HomeView) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        registerCellForReuse()
    }
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
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
        homeViewModel.delegate = self
        homeViewModel.downloadData()
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
        cell.selectionStyle = .none
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
        homeView.tableView.reloadData()
    }
    
    func didRecieveError(error: String?) {
        print(error!)
    }
}
