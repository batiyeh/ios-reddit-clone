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
    var posts: [Post] = []
    let networking: Networkable
    public weak var delegate: PostsTableViewDelegate?
    private weak var tableView: UITableView?
    private let disposeBag = DisposeBag()
    
    public init(networking: Networkable) {
        self.networking = networking
        super.init()
    }
    
    public convenience override init() {
        self.init(networking: Networking())
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
            fetchImage(urlString: thumbnail, image: cell.thumbnail)
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

extension PostsTableViewDataManager {
    /* Trivial solution of loading in images for each cell & there are some issues with it.
     Images won't update when switching subreddits and images have the potential to be in the
     wrong places if the cell is reused before its done downloading. */
    func fetchImage(urlString: String, image: UIImageView) {
        networking.request(urlString: urlString)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (data) in
                image.image = UIImage(data: data)
                image.contentMode = .scaleAspectFit
        }).disposed(by: disposeBag)
    }
}
