//
//  SubredditsEndpoints.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/16/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

enum SubredditsEndpoint: Endpoint {
    case popularEndpoints
    
    var baseUrl: String {
        return "https://www.reddit.com/"
    }
    
    var method: HttpMethod {
        switch self {
        case .popularEndpoints:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .popularEndpoints:
            return "subreddits/.json"
        }
    }
}
