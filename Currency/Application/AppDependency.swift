//
//  AppDependency.swift
//  Currency
//
//  Created by Thành Đỗ Long on 21/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Swinject

final class AppDependency {
    let container: Container
    
    init(container: Container = .init()) {
        self.container = container
        setupDependencies()
    }
    
    public func setupDependencies() {
        container.register(Networking.self) { _ in
            NetworkingImpl()
        }
        
        container.register(CurrencyService.self) { resolver in
            CurrencyServiceImpl(networking: resolver.resolve(Networking.self)!)
        }
        
        // ViewModels
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(currencyService: resolver.resolve(CurrencyService.self)!)
        }
        
        // ViewControllers
        container.register(HomeViewController.self) { resolver in
            HomeViewController(homeViewModel: resolver.resolve(HomeViewModel.self)!)
        }
        
        container.register(AddCurrencyViewController.self) { resolver in
            AddCurrencyViewController()
        }
    }
}
