//
//  PostsServiceTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class PostsServiceTests: XCTestCase {
    var subject: PostsService!
    let mockNetworking = MockNetworking()
    
    override func setUp() {
        subject = PostsService(networking: mockNetworking)
    }
    
    func testGetPostWithoutSubreddit() {
        _ = subject.getPosts(subreddit: nil)
        expect(self.mockNetworking.requestedUrl).to(equal("https://www.reddit.com/.json"))
    }
    
    func testGetPostWithSubreddit() {
        _ = subject.getPosts(subreddit: "pics")
        expect(self.mockNetworking.requestedUrl).to(equal("https://www.reddit.com/r/pics/.json"))
    }
    
    func testGetPostWithBlankSubreddit() {
        _ = subject.getPosts(subreddit: "")
        expect(self.mockNetworking.requestedUrl).to(equal("https://www.reddit.com/.json"))
    }
    
    func testGetPostsSuccess() {
        /* Ideally I would write a network stubbing response class where I could pass in a
         success / error response type w/ JSON and return it when a certain URL is called.
         I would then use this class to test both a success / error response.
         Unfortunately I ran out of time at this point. */
    }
}
