//
//  HomeViewModel.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

protocol HomeViewModelDelegate: class {
    func didRecieveDataUpdate()
    func didRecieveError(error: String?)
}

final class HomeViewModel {
    private var currencies: [Currency] = []
    private var selectedCurrencies: [Currency] {
        let defaults = UserDefaults.standard
        let selectedArray: [String] = defaults.array(forKey: "selectedCurrencies") as? [String] ?? [String]()

        return currencies.filter { currency -> Bool in
            selectedArray.contains(currency.code)
        }
    }

    private var filteredCurrencies: [Currency] = [] {
        didSet {
            delegate?.didRecieveDataUpdate()
        }
    }
    private var date: Date?
    private var base: String?
    private var rates: Rates = Rates()

    private let currencyService: CurrencyService
    public weak var delegate: HomeViewModelDelegate?

    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }

    public var data: [Currency] {
        return currencies
    }

    public var isFiltering: Bool {
        guard let query = query else { return false }
        return query.isEmpty ? false : true
    }

    public var query: String? {
        didSet {
            guard let query = query, query.isEmpty == false else {
                filteredCurrencies = []
                return
            }

            let result = selectedCurrencies.filter({ (currency) -> Bool in
                return currency.name.lowercased().contains(query.lowercased())
            })

            self.filteredCurrencies = result
        }
    }

    public var numberOfRowsInSection: Int {
        return isFiltering ? filteredCurrencies.count : selectedCurrencies.count
    }

    public func getCurrency(from index: Int) -> Currency {
        return isFiltering ? filteredCurrencies[index] : selectedCurrencies[index]
    }

    public func downloadData() {
        currencyService.getRates { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.currencies = self.loadJson(filename: "currencies")
                    self.date = response.timestamp
                    self.rates = response.rates

                    if let base = self.base {
                        self.currencyConvert(code: base)
                    } else {
                        self.currencyConvert(code: response.base)
                    }

                }
            case .failure(let error):
                self.delegate?.didRecieveError(error: error.errorDescription)
            }
        }
    }

    public func setBaseCurrency(for indexPath: IndexPath) {
        let currency = getCurrency(from: indexPath.row)
        self.base = currency.code
        currencyConvert(code: currency.code)
    }

    private func currencyConvert(code: String) {
        guard let basePrice = rates[code] else {
            delegate?.didRecieveError(error: "The currency cannot be converted.")
            return
        }

        self.rates = rates.compactMapValues({ (rate) -> Double in
            return rate/basePrice
        })

        self.delegate?.didRecieveDataUpdate()
    }

    private func loadJson(filename fileName: String) -> [Currency] {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(Array<Currency>.self, from: data)
                return jsonData
            } catch {
                delegate?.didRecieveError(error: error.localizedDescription)
            }
        }

        delegate?.didRecieveError(error: "The resource file could not be located.")
        return []
    }

    public func configureCell(_ view: CurrencyRateCell, for indexPath: IndexPath) {
        let currency = getCurrency(from: indexPath.row)
        guard let rates = rates[currency.code] else { return }

        if self.base == currency.code { view.isSelected = true
        } else { view.isSelected = false }

        view.currencyLabel.text = currency.name
        view.rateLabel.text = String(format: "%.\(currency.decimalDigits)f", rates)
        view.symbolLabel.text = currency.symbol
    }
}
