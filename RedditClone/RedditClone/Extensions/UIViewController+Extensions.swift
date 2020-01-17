//
//  UIViewController+Extensions.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func add(childViewController: UIViewController) {
        DispatchQueue.dispatchToMainAsync {
            self.addChild(childViewController)
            self.view.addSubview(childViewController.view)
            childViewController.didMove(toParent: self)
        }
    }
    
    public func remove(childViewController: UIViewController) {
        DispatchQueue.dispatchToMainAsync {
            childViewController.willMove(toParent: nil)
            childViewController.view.removeFromSuperview()
            childViewController.removeFromParent()
        }
    }
    
    public func showErrorBanner(errorMessage: String, dismissDuration: TimeInterval = 5.0) {
        let banner = Factory.views.banner(type: .error, text: errorMessage)
        banner.show(superview: view, dismissDuration: dismissDuration)
    }
}
