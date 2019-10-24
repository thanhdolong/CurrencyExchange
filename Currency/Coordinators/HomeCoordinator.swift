//
//  HomeCoordinator.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Swinject

final class HomeCoordinator: Coordinator {
    // MARK: - Instance Properties
    var children: [Coordinator] = []
    let container: Container
    let router: Router

    // MARK: - Object Lifecycle
    public init(router: Router, container: Container) {
        self.router = router
        self.container = container
    }

    // MARK: - Instance Methods
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = container.resolve(HomeViewController.self)!
        viewController.delegate = self
        let viewControllerEmbedIn = UINavigationController(rootViewController: viewController)
        router.present(viewControllerEmbedIn, animated: animated, onDismissed: onDismissed)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidPressAddCurrency(_ viewController: HomeViewController) {
        let router = ModalNavigationRouter(parentViewController: viewController)
        let coordinator = AddCurrencyCoordinator(router: router, container: container)
        presentChild(coordinator, animated: true, onDismissed: {
            viewController.homeViewModel.currencyConvert()
            viewController.homeView.tableView.reloadData()
        })
    }
}
