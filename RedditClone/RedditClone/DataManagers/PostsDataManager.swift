//
//  PostsDataManager.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import RxSwift
import UIKit

public protocol PostsTableViewDelegate: class {
    func postTapped(url: String)
}

class PostsTableViewDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    public weak var delegate: PostsTableViewDelegate?
    var posts: [Post] = []
    private weak var tableView: UITableView?
    private let disposeBag = DisposeBag()
    
    public override init() {
        super.init()
    }
    
    public func setup(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle = .none) {
        self.tableView = tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public func setPosts(posts: [Post]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    public func clearResults() {
        posts = []
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self),
                                 for: indexPath) as? PostTableViewCell
            else { return PostTableViewCell() }
        
        let post = posts[indexPath.row]
        cell.configure(post: post)
        if let thumbnail = post.thumbnail {
            cell.thumbnail.downloadImageFrom(urlString: thumbnail, contentMode: .scaleAspectFit)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        self.delegate?.postTapped(url: post.url)
    }
}
