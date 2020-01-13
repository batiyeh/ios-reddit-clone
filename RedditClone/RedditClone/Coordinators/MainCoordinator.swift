//
//  MainCoordinator.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import SafariServices
import UIKit

public protocol MainCoordinatorDelegate: class {
    func showPost(url: String)
}

class MainCoordinator: Coordinator, MainCoordinatorDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let postsViewController = PostsViewController()
        postsViewController.delegate = self
        navigationController.pushViewController(postsViewController, animated: false)
    }
    
    public func showPost(url: String) {
        guard let url = URL(string: url) else { return }
        let sfViewController = SFSafariViewController(url: url)
        navigationController.present(sfViewController, animated: true)
    }
}
