//
//  PostsViewModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public protocol PostViewable {
    func fetchPosts(subreddit: String?)
}

class PostsViewModel: PostViewable {
    let postsService: PostsServicable
    var posts: RedditResponse?
    
    init(postsService: PostsServicable) {
        self.postsService = postsService
    }
    
    public convenience init() {
        self.init(postsService: PostsService())
    }
    
    public func fetchPosts(subreddit: String?) {
        if let subreddit = subreddit {
            posts = postsService.getSubredditPosts(subreddit: subreddit)
        } else {
            posts = postsService.getHomePosts()
        }
    }
}
