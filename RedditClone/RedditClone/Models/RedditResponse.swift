//
//  PostsModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public struct RedditResponse: Decodable {
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case children
    }
    
    enum PostDataKeys: String, CodingKey {
        case data
    }
    
    enum PostKeys: String, CodingKey {
        case title
        case subreddit
        case url
        case id
        case thumbnail
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        
        var postsUnkeyedContainer = try dataContainer.nestedUnkeyedContainer(forKey: .children)
        var postsArray = [Post]()
        while !postsUnkeyedContainer.isAtEnd {
            let postContainer = try postsUnkeyedContainer.nestedContainer(keyedBy: PostDataKeys.self)
            postsArray.append(try postContainer.decode(Post.self, forKey: .data))
        }
        self.posts = postsArray
    }
}
