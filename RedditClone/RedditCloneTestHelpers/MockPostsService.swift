//
//  MockPostsService.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/17/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RedditClone
import RxSwift

class MockPostsService: PostsServicable {
    public var getPostsCalled = false
    private let postsResponse = PostsResponse(posts: [])
    
    public init() { }
    
    func getPosts(subreddit: String?) -> Observable<PostsResponse> {
        getPostsCalled = true
        return Observable.just(postsResponse)
    }
}
