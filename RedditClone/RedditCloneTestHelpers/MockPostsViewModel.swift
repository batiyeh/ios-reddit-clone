//
//  MockPostsViewModel.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/17/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RedditClone
import RxCocoa
import RxSwift

public class MockPostsViewModel: PostsViewable {
    public var fetchPostsCalled = false
    let post = Post(title: "", subreddit: "", url: "", id: "", thumbnail: nil)
    
    public init() { }
    
    public var posts = BehaviorRelay<[Post]>(value: [])
    
    public var showBanner = BehaviorRelay<Bool>(value: false)
    
    public var pageTitle = BehaviorRelay<String>(value: "Reddit Home")
    
    public func fetchPosts(subreddit: String?) {
        fetchPostsCalled = true
        posts.accept([post])
    }
}
