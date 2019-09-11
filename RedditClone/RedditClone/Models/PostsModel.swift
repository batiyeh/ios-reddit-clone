//
//  PostsModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

struct RedditResponse: Decodable {
    let kind: String
    let data: PostResponse
    
    enum CodingKeys: String, CodingKey {
        case data
        case kind
    }
}

struct PostResponse: Decodable {
    let posts: [PostModel]
    
    enum CodingKeys: String, CodingKey {
        case posts = "children"
    }
}

struct PostModel: Decodable {
    let kind: String
    let data: SinglePostModel
}

struct SinglePostModel: Decodable {
    let title: String
    let subreddit: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case title
        case subreddit
        case url
    }
}
