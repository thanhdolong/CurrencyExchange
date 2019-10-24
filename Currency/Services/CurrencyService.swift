//
//  CurrencyService.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

protocol CurrencyService: class {
    typealias FixerResult = Result<FixerLatestRatesResponse, AFError>
    func getRates(result: @escaping (FixerResult) -> Void)
}

final class CurrencyServiceImpl: CurrencyService {
    private var networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func getRates(result: @escaping (FixerResult) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        networking.fetchDecodable(route: FixerRoute.latestRate, decoder: decoder) { (response: FixerResult) in
            switch response {
            case .success(let values):
                result(.success(values))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
