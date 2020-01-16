//
//  Subreddit.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/16/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

public struct Subreddit: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
    }
}
