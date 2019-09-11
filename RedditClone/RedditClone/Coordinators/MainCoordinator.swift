//
//  MainCoordinator.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

public protocol CoordinatorDelegate {
    func showPostURL()
}

class MainCoordinator: Coordinator, CoordinatorDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PostsViewController()
        navigationController.pushViewController(vc, animated: false)
    }
    
    public func showPostURL() {
        print("Show the post!")
    }
}
