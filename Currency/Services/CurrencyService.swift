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
    func getRates(result: @escaping (Result<[Currency], AFError>) -> Void)
}

final class CurrencyServiceImpl: CurrencyService {
    private var networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getRates(result: @escaping (Result<[Currency], AFError>) -> Void) {
        networking.fetchDecodable(route: FixerRoute.latest, decoder: JSONDecoder()) { (response: Result<FixerLatestResponse, AFError>) in
            switch response {
            case .success(let values):
                print(values)
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
