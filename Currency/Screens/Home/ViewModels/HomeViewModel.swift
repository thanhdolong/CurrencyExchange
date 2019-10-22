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
    private var date: Date?
    private var base: String?
    private var rates: [String:Double] = [:]
    
    private let currencyService: CurrencyService
    public weak var delegate: HomeViewModelDelegate?
    
    init(currencyService: CurrencyService) {
        self.currencyService = currencyService
    }
    
    public var data: [Currency] {
        return currencies
    }
    
    public var numberOfRowsInSection: Int {
        return currencies.count
    }
    
    public func getCurrency(from index: Int) -> Currency {
        return currencies[index]
    }
    
    public func downloadData() {
        self.currencies = loadJson(filename: "currencies")
        
        currencyService.getRates { result in
            switch(result) {
            case .success(let response):
                DispatchQueue.main.async {
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
        currencyConvert(code: currency.code)
    }
    
    private func currencyConvert(code: String) {
        guard let basePrice = rates[code] else {
            delegate?.didRecieveError(error: "Something during converting went wrong.")
            return
        }
        
        self.base = code
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
        
        view.currencyLabel.text = currency.name
        view.rateLabel.text = String(format: "%.\(currency.decimalDigits)f", rates)
        view.symbolLabel.text = currency.symbol
    }
}
