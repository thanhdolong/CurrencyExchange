//
//  HomeViewModel.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

final class HomeViewModel {
    private let currencies: [Currency] = []
    private var base: String?
    private var date: Date?
    
    private let currencyService: CurrencyService
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
}
