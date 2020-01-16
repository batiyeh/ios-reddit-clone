//
//  PostsService.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/11/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsServicable {
    func getPosts(subreddit: String?) -> Observable<PostsResponse>
}

class PostsService: PostsServicable {
    private let networking: Networkable
    
    public init(networking: Networkable) {
        self.networking = networking
    }
    
    public convenience init() {
        self.init(networking: Networking())
    }
    
    public func getPosts(subreddit: String?) -> Observable<PostsResponse> {
        var endpoint: Endpoint
        if let subreddit = subreddit,
            subreddit.count == 0 {
            endpoint = PostsEndpoint.home
        } else if let subreddit = subreddit {
            endpoint = PostsEndpoint.subreddit(subreddit: subreddit)
        } else {
            endpoint = PostsEndpoint.home
        }
        
        return networking.request(request: endpoint.buildUrlRequest())
    }
}
