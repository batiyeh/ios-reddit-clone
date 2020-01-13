//
//  PopularSubredditsViewController.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

class PopularSubredditsViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .darkGray
    }
}
