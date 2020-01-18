//
//  Post.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/13/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

public struct Post: Decodable {
    let title: String
    let subreddit: String
    let url: String
    let id: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subreddit
        case url
        case id
        case thumbnail
    }
    
    public init(title: String,
                subreddit: String,
                url: String,
                id: String,
                thumbnail: String?) {
        self.title = title
        self.subreddit = subreddit
        self.url = url
        self.id = id
        self.thumbnail = thumbnail
    }
}
