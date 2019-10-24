//
//  FixerRoute.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

public enum FixerRoute {
    case latestRate
}

extension FixerRoute: Route {
    var baseURL: String {
        return "http://data.fixer.io/api"
    }

    var method: HTTPMethod {
        switch self {
        case .latestRate:
            return .get
        }
    }

    var path: String {
        switch self {
        case .latestRate:
            return "/latest"
        }
    }

    var accessKey: String {
        let file = Bundle.main.path(forResource: "Fixer", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: file)!
        return dictionary["key"] as! String
    }

    var parameters: Parameters? {
        switch self {
        case .latestRate:
            return [
                "access_key": accessKey
            ]
        }
    }
}
