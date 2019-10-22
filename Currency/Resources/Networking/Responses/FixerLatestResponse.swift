//
//  FixerLatestResponse.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation

struct FixerLatestResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base: String
//    let date: Date
    let rates: [String: Double]
}
