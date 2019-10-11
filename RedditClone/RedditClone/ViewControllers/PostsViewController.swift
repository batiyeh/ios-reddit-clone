//
//  PostsViewController.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

class PostsViewController: UIViewController {
    public weak var delegate: MainCoordinatorDelegate?
    let postsViewModel: PostViewable
    let postsDataManager: PostsTableViewDataManager
    let postsView = PostsView()
    private let disposeBag = DisposeBag()
    
    init(postsViewModel: PostViewable,
         postsDataManager: PostsTableViewDataManager) {
        self.postsViewModel = postsViewModel
        self.postsDataManager = postsDataManager
        self.postsDataManager.setup(tableView: postsView.tableView)
        super.init(nibName: nil, bundle: nil)
        self.postsDataManager.delegate = self
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
        postsObservable()
        postsViewModel.fetchPosts(subreddit: nil)
        setupNavigationBar()
        setupView()
    }
    
    private func postsObservable() {
        postsViewModel.posts
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] posts in
                self?.postsDataManager.setPosts(posts: posts)
        }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "Reddit Home"
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

extension PostsViewController: PostsTableViewDelegate {
    func postTapped(url: String) {
        delegate?.showPost(url: url)
    }
}

