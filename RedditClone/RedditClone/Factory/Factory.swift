//
//  Factory.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/15/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation

// Factory can be used to place repeatedly used things across the app
// like fonts, colors, views, and images
public struct Factory {
    public static var views = Views()
}
