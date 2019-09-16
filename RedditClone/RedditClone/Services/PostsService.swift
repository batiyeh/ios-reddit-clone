//
//  PostsService.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/11/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public protocol PostsServicable {
    func getHomePosts() -> RedditResponse?
    func getSubredditPosts(subreddit: String) -> RedditResponse?
}

class PostsService: PostsServicable {
    let baseUrl = "https://www.reddit.com/"
    let json = ".json"
    
    func getHomePosts() -> RedditResponse? {
        var response: RedditResponse? = nil
        if let url = URL(string: baseUrl + json) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
                if let data = data,
                    let jsonString = String(data: data, encoding: .utf8) {
                    
                    let decoder = JSONDecoder()
                    response = try? decoder.decode(RedditResponse.self, from: jsonString.data(using: .utf8)!)
                }
            }.resume()
        }
        return response
    }
    
    func getSubredditPosts(subreddit: String) -> RedditResponse? {
        var response: RedditResponse? = nil
        if let url = URL(string: baseUrl + subreddit + json) {
            URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
                if let data = data,
                    let jsonString = String(data: data, encoding: .utf8) {
                    
                    let decoder = JSONDecoder()
                    response = try? decoder.decode(RedditResponse.self, from: jsonString.data(using: .utf8)!)
                }
                }.resume()
        }
        return response
    }
}
