//
//  Networking.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
}

typealias NetworkingResult<Value> = (Result<Value, Error>) -> Void

protocol Networkable {
    func request<T: Endpoint>(_ endpoint: T, completion: @escaping NetworkingResult<T.Response>)
}

protocol Endpoint: Encodable {
    associatedtype Response: Decodable
    var method: HttpMethod { get }
    var baseUrl: String { get }
    var path: String { get }
}

class Networking: Networkable {
    func request<T>(_ endpoint: T, completion: @escaping (Result<T.Response, Error>) -> Void) where T: Endpoint {
        let url = buildUrl(endpoint)
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data,
                let jsonString = String(data: data, encoding: .utf8) {
                if let response = try? JSONDecoder().decode(T.Response.self, from: jsonString.data(using: .utf8)!) {
                    completion(.success(T.Response))
                } else {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func buildUrl<T>(_ endpoint: T) -> URL where T: Endpoint {
        print(endpoint.baseUrl)
    }
}
