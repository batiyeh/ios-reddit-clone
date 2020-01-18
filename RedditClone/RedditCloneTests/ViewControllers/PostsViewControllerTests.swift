//
//  PostsViewControllerTests.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/17/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Nimble
import XCTest

@testable import RedditClone

class PostsViewControllerTests: XCTestCase {
    var subject: PostsViewController!
    var mockPostsViewModel = MockPostsViewModel()
    
    override func setUp() {
        subject = PostsViewController(postsViewModel: mockPostsViewModel)
    }

    func testShouldFetchPostsOnLoad() {
        subject.viewDidLoad()
        expect(self.mockPostsViewModel.fetchPostsCalled).to(beTruthy())
    }
    
    func testShouldOpenSubredditVCOnTextFieldTap() {
        subject.textFieldDidBeginEditing(subject.postsView.searchTextField)
        expect(self.subject.children.count).to(equal(1))
        expect(self.subject.children[0]).to(beAnInstanceOf(SubredditsViewController.self))
    }
    
    func testShouldFetchPostsOnSearchDone() {
        subject.doneButtonPressed()
        expect(self.mockPostsViewModel.fetchPostsCalled).to(beTruthy())
    }
    
    func testShouldRemoveSubredditVcOnSearchDone() {
        subject.textFieldDidEndEditing(subject.postsView.searchTextField)
        expect(self.subject.children.count).to(equal(0))
    }
    
    func testShouldUpdateTitleOnDoneSearching() {
        subject.viewDidLoad()
        mockPostsViewModel.pageTitle.accept("New Title")
        expect(self.subject.title).to(equal("New Title"))
    }
    
    func testShouldUpdatePostsOnFetch() {
        subject.viewDidLoad()
        expect(self.subject.postsDataManager.posts.count).to(equal(1))
    }
    
    func testShouldShowErrorBannerOnError() {
        subject.viewDidLoad()
        mockPostsViewModel.showBanner.accept(true)
        expect(self.subject.view.subviews[2]).to(beAnInstanceOf(Banner.self))
    }
}
