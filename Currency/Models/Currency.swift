//
//  Currency.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let symbol: String
    let name: String
    let symbolNative: String
    let decimalDigits: Int
    let rounding: Double
    let code: String
    let namePlural: String
    let flag: URL
}
