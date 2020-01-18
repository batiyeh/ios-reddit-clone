//
//  MockSubredditsService.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RedditClone
import RxSwift

class MockSubredditService: SubredditServicable {
    public var getPopularSubredditsCalled = false
    let subredditResponse = SubredditResponse(subreddits: [])
    
    func getPopularSubreddits() -> Observable<SubredditResponse> {
        getPopularSubredditsCalled = true
        return Observable.of(subredditResponse)
    }
}
