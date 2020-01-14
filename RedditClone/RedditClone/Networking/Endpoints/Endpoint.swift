//
//  Endpoint.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/13/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

//protocol Networkable {
//    var method: HttpMethod { get }
//    var baseUrl: String { get }
//    var path: String { get }
//}

//class EndpointType<Response> {
//    let method: HttpMethod
//    let path: String
//    let decode: (Data) throws -> Response
//
//    init(method: HttpMethod,
//         path: String,
//         decode: @escaping (Data) throws -> Response) {
//        self.method = method
//        self.path = path
//        self.decode = decode
//    }
//}
//
//extension EndpointType where Response: Decodable {
//    convenience init(method: HttpMethod, path: String) {
//        self.init(method: method, path: path) {
//            try JSONDecoder().decode(Response.self, from: $0)
//        }
//    }
//}
