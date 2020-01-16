//
//  PostsEndpoint.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/14/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

enum PostsEndpoint: Endpoint {
    case home
    case subreddit(subreddit: String)
    
    var baseUrl: String {
        return "https://www.reddit.com/"
    }
    
    var method: HttpMethod {
        switch self {
        case .home:
            return .GET
        case .subreddit:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .home:
            return ".json"
        case .subreddit(let subreddit):
            return "/r/" + subreddit + "/.json"
        }
    }
}
