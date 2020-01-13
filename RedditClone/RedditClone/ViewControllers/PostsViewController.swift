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
    var popularSubredditsVC: PopularSubredditsViewController?
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        setupNavigationBar()
        view.backgroundColor = .white
        
        view.addSubview(postsView)
        self.postsView.searchTextField.delegate = self
        postsView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupPopularSubredditsView() {
        popularSubredditsVC = PopularSubredditsViewController()
        if let popularSubreddits = popularSubredditsVC {
            add(childViewController: popularSubreddits)
            popularSubreddits.view.snp.makeConstraints { (make) in
                make.top.equalTo(postsView.searchTextField.snp.bottom).offset(10)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    private func removePopularSubredditsView() {
        if let popularSubreddits = popularSubredditsVC {
            remove(childViewController: popularSubreddits)
            popularSubredditsVC = nil
        }
    }
}

extension PostsViewController: PostsTableViewDelegate {
    func postTapped(url: String) {
        delegate?.showPost(url: url)
    }
}

extension PostsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupPopularSubredditsView()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        removePopularSubredditsView()
    }
}
