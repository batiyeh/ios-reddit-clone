//
//  DispatchQueue+Extensions.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

extension DispatchQueue {
    public static func dispatchToMainAsync(_ code: @escaping () -> Void) {
        if Thread.isMainThread {
            return code()
        }
        
        DispatchQueue.main.async {
            code()
        }
    }
}
