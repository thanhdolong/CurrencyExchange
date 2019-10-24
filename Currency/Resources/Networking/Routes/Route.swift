//
//  Route.swift
//  Currency
//
//  Created by Thành Đỗ Long on 22/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Alamofire

protocol Route: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension Route {
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Parameters
        if let parameters = parameters {
            do {
                if method == .get {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                } else {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
