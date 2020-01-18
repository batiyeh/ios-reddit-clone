//
//  PostsViewModelTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/17/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class PostsViewModelTests: XCTestCase {
    var subject: PostsViewModel!
    let mockPostsService = MockPostsService()
    
    override func setUp() {
        subject = PostsViewModel(postsService: mockPostsService)
    }
    
    func testShouldCallGetPosts() {
        subject.fetchPosts(subreddit: nil)
        expect(self.mockPostsService.getPostsCalled).to(beTruthy())
    }
}
