//
//  SubredditResponse.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/16/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

public struct SubredditResponse: Decodable {
    let subreddits: [Subreddit]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case children
    }
    
    enum SubredditDataKeys: String, CodingKey {
        case data
    }
    
    enum SubredditKeys: String, CodingKey {
        case display_name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        
        var subredditsUnkeyedContainer = try dataContainer.nestedUnkeyedContainer(forKey: .children)
        var subredditArray = [Subreddit]()
        while !subredditsUnkeyedContainer.isAtEnd {
            let subredditContainer = try subredditsUnkeyedContainer.nestedContainer(keyedBy: SubredditDataKeys.self)
            subredditArray.append(try subredditContainer.decode(Subreddit.self, forKey: .data))
        }
        self.subreddits = subredditArray
    }
}
