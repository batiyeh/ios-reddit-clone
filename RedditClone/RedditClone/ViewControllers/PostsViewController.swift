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
    var subredditsViewController: SubredditsViewController?
    private let disposeBag = DisposeBag()
    
    init(postsViewModel: PostViewable,
         postsDataManager: PostsTableViewDataManager) {
        self.postsViewModel = postsViewModel
        self.postsDataManager = postsDataManager
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
        self.postsDataManager.setup(tableView: postsView.tableView)
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
        
        postsViewModel.pageTitle
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (title) in
            self?.title = title
        }).disposed(by: disposeBag)
    }
    
    @objc private func doneButtonPressed() {
        postsView.searchTextField.resignFirstResponder()
        postsViewModel.fetchPosts(subreddit: postsView.searchTextField.text)
    }
    
    private func setupNavigationBar() {
        title = "Reddit Home"
        navigationController?.styleNavigationBarTitle()
    }
    
    private func setupView() {
        setupNavigationBar()
        view.backgroundColor = .white
        
        view.addSubview(postsView)
        setupSearchTextField()
        postsView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSearchTextField() {
        postsView.searchTextField.delegate = self
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        let items = [flexSpace, done]
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.postsView.searchTextField.inputAccessoryView = doneToolbar
    }
    
    private func setupPopularSubredditsView() {
        subredditsViewController = SubredditsViewController()
        if let popularSubreddits = subredditsViewController {
            add(childViewController: popularSubreddits)
            popularSubreddits.view.snp.makeConstraints { (make) in
                make.top.equalTo(postsView.searchTextField.snp.bottom).offset(10)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
    
    private func removePopularSubredditsView() {
        if let popularSubreddits = subredditsViewController {
            remove(childViewController: popularSubreddits)
            subredditsViewController = nil
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
