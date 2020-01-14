//
//  Endpoint.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/13/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
}

class Endpoint<Response> {
    let method: HttpMethod
    let path: String
    let decode: (Data) throws -> Response
    
    init(method: HttpMethod = .get,
         path: String,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.decode = decode
    }
}

extension Endpoint where Response: Swift.Decodable {
    convenience init(method: HttpMethod = .get, path: String) {
        self.init(method: method, path: path) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}
