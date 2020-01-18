//
//  Router.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

public protocol Routable {
    var rootViewController: UIViewController? { get }
    var topViewController: UIViewController? { get }
    
    func present(viewController: UIViewController, animated: Bool)
    func push(viewController: UIViewController, animated: Bool)
}

public class Router: Routable {
    let navigationController: UINavigationController
    
    public var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }
    
    public var topViewController: UIViewController? {
        return navigationController.topViewController
    }
    
    public init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    public func present(viewController: UIViewController, animated: Bool = true) {
        navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    public func push(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}
