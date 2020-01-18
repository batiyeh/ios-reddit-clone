//
//  SubredditsViewControllerTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class SubredditsViewControllerTests: XCTestCase {
    var subject: SubredditsViewController!
    let mockSubredditsViewModel = MockSubredditsViewModel()
    
    override func setUp() {
        subject = SubredditsViewController(subredditsViewModel: mockSubredditsViewModel)
    }
    
    func testFetchPopularSubreddits() {
        subject.viewDidLoad()
        expect(self.mockSubredditsViewModel.fetchPopularSubredditsCalled).to(beTruthy())
    }
}
