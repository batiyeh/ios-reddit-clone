//
//  MockSubredditsViewModel.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RedditClone
import RxCocoa

public class MockSubredditsViewModel: SubredditsViewable {
    public var popularSubreddits = BehaviorRelay<[Subreddit]>(value: [])
    public var fetchPopularSubredditsCalled = false
    
    public func fetchPopularSubreddits() {
        fetchPopularSubredditsCalled = true
    }
}
