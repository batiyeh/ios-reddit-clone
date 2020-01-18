//
//  SubredditsViewModelTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class SubredditsViewModelTests: XCTestCase {
    var subject: SubredditsViewModel!
    let mockSubredditsService = MockSubredditService()
    
    override func setUp() {
        subject = SubredditsViewModel(subredditsService: mockSubredditsService)
    }
    
    func testShouldFetchSubreddits() {
        subject.fetchPopularSubreddits()
        expect(self.mockSubredditsService.getPopularSubredditsCalled).to(beTruthy())
    }
}
