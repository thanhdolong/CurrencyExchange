//
//  NetworkingManager.swift
//
//  Created by Thành Đỗ Long on 28/09/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking: class {
    func fetchDecodable<T: Decodable>(route: Route, decoder: JSONDecoder, completion: @escaping (Result<T, AFError>) -> Void)
}

class NetworkingImpl: Networking {
    private let urlSession = URLSession.shared

    internal func fetchDecodable<T: Decodable>(route: Route, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) {

        AF.request(route).validate().responseDecodable(of: T.self,
                                                       decoder: decoder,
                                                       completionHandler: { (response) in

            switch response.result {
            case .success(let values):
                completion(.success(values))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
