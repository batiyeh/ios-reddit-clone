//
//  PopularSubredditsViewModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/16/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol SubredditsViewable {
    var popularSubreddits: BehaviorRelay<[Subreddit]> { get }
    func fetchPopularSubreddits()
}

class SubredditsViewModel: SubredditsViewable {
    public var popularSubreddits = BehaviorRelay<[Subreddit]>(value: [])
    let subredditsService: SubredditServicable
    let disposeBag = DisposeBag()
    
    init(subredditsService: SubredditServicable) {
        self.subredditsService = subredditsService
    }
    
    public convenience init() {
        self.init(subredditsService: SubredditService())
    }
    
    public func fetchPopularSubreddits() {
        subredditsService.getPopularSubreddits().subscribe(onNext: { [weak self] (response) in
            self?.popularSubreddits.accept(response.subreddits)
        }, onError: { (error) in
            // TODO: Handle gracefully with error banner
            print("Error fetching popular subreddits")
        }).disposed(by: disposeBag)
    }
}
