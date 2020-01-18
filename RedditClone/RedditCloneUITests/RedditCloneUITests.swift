//
//  RedditCloneUITests.swift
//  RedditCloneUITests
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import XCTest

class RedditCloneUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        App.shared.launch()
    }

    func testSearchTextFieldTap() {
        HomeScreen.searchTextField.tap()
        waitForExistence(SubredditScreen.doneButton)
        XCTAssertTrue(SubredditScreen.doneButton.exists)
    }
}
