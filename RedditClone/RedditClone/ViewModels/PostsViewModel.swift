//
//  PostsViewModel.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation

public protocol PostViewable {
    func fetchPosts(subreddit: String?)
}

class PostsViewModel: PostViewable {
    let url = "https://www.reddit.com/.json"
    var posts: RedditResponse?
    
    public func fetchPosts(subreddit: String?) {
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] (data, urlResponse, _) in
            if let data = data,
                let jsonString = String(data: data, encoding: .utf8) {
                
                let decoder = JSONDecoder()
                do {
                    self?.posts = try decoder.decode(RedditResponse.self, from: jsonString.data(using: .utf8)!)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
