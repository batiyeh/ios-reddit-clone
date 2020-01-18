//
//  MainCoordinator.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import SafariServices
import UIKit

public protocol HomeCoordinatorDelegate: class {
    func showPost(url: String)
}

class HomeCoordinator: Coordinator, HomeCoordinatorDelegate {
    var childCoordinators = [Coordinator]()
    let router: Routable
    
    init(router: Routable) {
        self.router = router
    }
    
    func start() {
        let postsViewController = PostsViewController()
        postsViewController.delegate = self
        router.push(viewController: postsViewController, animated: false)
    }
    
    public func showPost(url: String) {
        guard let url = URL(string: url) else { return }
        let sfViewController = SFSafariViewController(url: url)
        router.present(viewController: sfViewController, animated: true)
    }
}
