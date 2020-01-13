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
    private weak var tableView: UITableView?
    private var posts: [PostModel] = []
    private let disposeBag = DisposeBag()
    
    public override init() {
        super.init()
    }
    
    public func setup(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle = .none) {
        self.tableView = tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public func setPosts(posts: [PostModel]) {
        self.posts = posts
        tableView?.reloadData()
    }
    
    public func clearResults() {
        posts = []
        tableView?.reloadData()
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
        cell.configure(post: post.data)
        if let thumbnail = post.data.thumbnail {
            cell.thumbnail.downloadImageFrom(urlString: thumbnail, contentMode: .scaleAspectFit)
        }
        
        cell.tapped.subscribe(onNext: { [weak self] _ in
            self?.delegate?.postTapped(url: post.data.url)
        }).disposed(by: disposeBag)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
