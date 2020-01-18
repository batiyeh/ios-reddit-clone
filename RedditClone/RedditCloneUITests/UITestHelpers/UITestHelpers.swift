//
//  UITestHelpers.swift
//  RedditCloneUITests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import XCTest

private let timeout: TimeInterval = 10

public func waitForExistence(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
    if !element.waitForExistence(timeout: timeout) {
        XCTFail("Timed out waiting for element: \(element) to appear", file: file, line: line)
    }
}
