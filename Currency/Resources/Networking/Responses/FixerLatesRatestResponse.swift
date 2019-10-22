//
//  FixerLatestResponse.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

struct FixerLatestRatesResponse: Decodable {
    let timestamp: Date
    let base: String
    let rates: [String: Double]
}
