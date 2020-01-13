//
//  Networking.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

typealias NetworkingResult<Value> = (Result<Value, Error>) -> Void

protocol Networking {
    func get<T: Request>(_ request: T, completion: @escaping NetworkingResult<T.Response>)
}

protocol Request: Encodable {
    associatedtype Response: Decodable
    var resourceName: String { get }
}
