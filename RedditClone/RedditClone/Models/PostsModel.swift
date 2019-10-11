//
//  PostsModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public struct RedditResponse: Decodable {
    let kind: String
    let data: PostResponse
    
    enum CodingKeys: String, CodingKey {
        case data
        case kind
    }
}

public struct PostResponse: Decodable {
    let posts: [PostModel]
    
    enum CodingKeys: String, CodingKey {
        case posts = "children"
    }
}

public struct PostModel: Decodable {
    let kind: String
    let data: SinglePostModel
}

public struct SinglePostModel: Decodable {
    let title: String
    let subreddit: String
    let url: String
    let id: String
    let thumbnail: String?
    let thumbHeight: Int?
    let thumbWidth: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subreddit
        case url
        case id
        case thumbnail
        case thumbHeight = "thumbnail_height"
        case thumbWidth = "thumbnail_width"
    }
}
