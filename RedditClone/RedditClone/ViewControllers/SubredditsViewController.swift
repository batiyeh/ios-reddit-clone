//
//  PopularSubredditsViewController.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class SubredditsViewController: UIViewController {
    private let subredditsViewModel: SubredditsViewable
    private let disposeBag = DisposeBag()
    
    public init(subredditsViewModel: SubredditsViewable) {
        self.subredditsViewModel = subredditsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init() {
        self.init(subredditsViewModel: SubredditsViewModel())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSubredditsObservable()
        subredditsViewModel.fetchPopularSubreddits()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func setupSubredditsObservable() {
        subredditsViewModel.popularSubreddits
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] subreddits in
                // TODO: Assign subreddits to a data manager & display
                print(subreddits)
        }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.backgroundColor = .lightGray
    }
    
    // TODO: Build out popular subreddits table view and display on this VC
}
