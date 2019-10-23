//
//  AddCurrencyViewModel.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

protocol AddCurrencyViewModelDelegate: class {
    func didRecieveDataUpdate()
    func didRecieveError(error: String?)
}

final class AddCurrencyViewModel {
    typealias GroupedCurrecies = Dictionary<String, [Currency]>
    private var currencies: GroupedCurrecies = GroupedCurrecies() {
        didSet {
            delegate?.didRecieveDataUpdate()
        }
    }
    
    private var filteredCurrencies: [Currency] = [] {
        didSet {
            delegate?.didRecieveDataUpdate()
        }
    }
    
    public weak var delegate: AddCurrencyViewModelDelegate?
    
    public var data: GroupedCurrecies {
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
            
//            let result = currencies.filter({ (currency) -> Bool in
//                return currency.name.lowercased().contains(query.lowercased())
//            })
            
//            self.filteredCurrencies = result
        }
    }
    
    public func getAllKeys() -> [String] {
        return Array(currencies.keys).sorted()
    }
    
    public func getKeyFrom(_ section: Int) -> String {
        return getAllKeys()[section]
    }
    
    public var numberOfSections: Int {
        return currencies.count
    }
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        let key = getKeyFrom(section)
        return currencies[key]!.count
    }
    
    public func downloadData() {
        let unsortedCurrencires = self.loadJson(filename: "currencies")
        self.currencies = Dictionary(grouping: unsortedCurrencires, by: { (currency) -> String in
            String(currency.name.first!)
        })
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
}
