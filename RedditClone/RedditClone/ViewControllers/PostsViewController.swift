//
//  PostsViewController.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import SnapKit
import UIKit

class PostsViewController: UIViewController {
    let postsViewModel: PostViewable
    let postsDataManager: PostsTableViewDataManager
    let postsView: PostsView
    
    init(postsViewModel: PostViewable,
         postsDataManager: PostsTableViewDataManager) {
        self.postsViewModel = postsViewModel
        self.postsDataManager = postsDataManager
        self.postsView = PostsView()
        self.postsDataManager.setup(tableView: postsView.tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init() {
        self.init(postsViewModel: PostsViewModel(),
                  postsDataManager: PostsTableViewDataManager())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsViewModel.fetchPosts(subreddit: nil)
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar() {
        title = "Reddit Clone"
        navigationController?.styleNavigationBarTitle()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(postsView)
        postsView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

