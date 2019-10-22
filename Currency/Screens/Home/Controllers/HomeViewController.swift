//
//  HomeViewController.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModel
    var homeView: HomeView! { return (view as! HomeView) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello world")
        // Do any additional setup after loading the view.
    }
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
