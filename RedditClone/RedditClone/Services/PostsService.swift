//
//  PostsService.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/11/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public typealias ServiceCompletion = (_ response: RedditResponse) -> Void

public protocol PostsServicable {
    func getHomePosts(completionHandler: @escaping ServiceCompletion)
    func getSubredditPosts(subreddit: String, completionHandler: @escaping ServiceCompletion)
}

class PostsService: PostsServicable {
    let baseUrl = "https://www.reddit.com/"
    let json = ".json"
    
    func getHomePosts(completionHandler: @escaping ServiceCompletion) {
        if let url = URL(string: baseUrl + json) {
            fetchData(url: url, completionHandler: completionHandler)
        }
    }
    
    func getSubredditPosts(subreddit: String, completionHandler: @escaping ServiceCompletion) {
        if let url = URL(string: baseUrl + subreddit + json) {
            fetchData(url: url, completionHandler: completionHandler)
        }
    }
    
    func fetchData(url: URL, completionHandler: @escaping ServiceCompletion) {
        URLSession.shared.dataTask(with: url) { (data, urlResponse, _) in
            if let data = data,
                let jsonString = String(data: data, encoding: .utf8) {
                if let response = try? JSONDecoder().decode(RedditResponse.self, from: jsonString.data(using: .utf8)!) {
                    completionHandler(response)
                }
            }
        }.resume()
    }
}
