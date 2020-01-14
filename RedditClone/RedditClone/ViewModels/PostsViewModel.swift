//
//  PostsViewModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import RxCocoa

public protocol PostViewable {
    var posts: BehaviorRelay<[Post]> { get }
    func fetchPosts(subreddit: String?)
}

class PostsViewModel: PostViewable {
    public var posts = BehaviorRelay<[Post]>(value: [])
    let postsService: PostsServicable
    
    init(postsService: PostsServicable) {
        self.postsService = postsService
    }
    
    public convenience init() {
        self.init(postsService: RedditService())
    }
    
    public func fetchPosts(subreddit: String?) {
        if let subreddit = subreddit {
            postsService.getSubredditPosts(subreddit: subreddit, completionHandler: setPosts)
        } else {
            postsService.getHomePosts(completionHandler: setPosts)
        }
    }
    
    private func setPosts(response: RedditResponse) {
        posts.accept(response.posts)
    }
}
