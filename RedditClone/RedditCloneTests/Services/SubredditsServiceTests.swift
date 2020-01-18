//
//  MockSubredditsServiceTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class SubredditsServiceTests: XCTestCase {
    var subject: SubredditService!
    let mockNetworking = MockNetworking()
    
    override func setUp() {
        subject = SubredditService(networking: mockNetworking)
    }
    
    func testPopularSubredditsUrl() {
        let _ = subject.getPopularSubreddits()
        expect(self.mockNetworking.requestedUrl).to(equal("https://www.reddit.com/subreddits/.json"))
    }
}
