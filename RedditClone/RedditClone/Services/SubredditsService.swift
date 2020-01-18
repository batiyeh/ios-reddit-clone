//
//  SubredditsService.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/16/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift

public protocol SubredditServicable {
    func getPopularSubreddits() -> Observable<SubredditResponse>
}

public class SubredditService: SubredditServicable {
    private let networking: Networkable
    
    public init(networking: Networkable) {
        self.networking = networking
    }
    
    public convenience init() {
        self.init(networking: Networking())
    }
    
    public func getPopularSubreddits() -> Observable<SubredditResponse> {
        let endpoint = SubredditsEndpoint.popularEndpoints
        return networking.request(request: endpoint.buildUrlRequest())
    }
}
