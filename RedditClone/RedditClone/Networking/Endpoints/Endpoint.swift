//
//  Endpoint.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/13/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

protocol Endpoint: Encodable {
    associatedtype Response: Decodable
    var method: HttpMethod { get }
    var baseUrl: String { get }
    var path: String { get }
    
    func buildUrl() -> URL
}
