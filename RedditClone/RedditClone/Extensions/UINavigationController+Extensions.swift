//
//  UINavigationController+Extensions.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func styleNavigationBarTitle(prefersLargeTitles: Bool = true) {
        navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationBar.barTintColor = .white
        navigationBar.layoutMargins.left = 25
        navigationBar.shadowImage = UIImage()
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28,
                                                                                                 weight: .bold)]
    }
}
