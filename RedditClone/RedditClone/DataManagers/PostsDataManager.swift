//
//  PostsDataManager.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import UIKit

class PostsTableViewDataManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView?
    private var results: [String] = ["Hello"]
    
    public override init() {
        super.init()
    }
    
    public func setup(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle = .none) {
        self.tableView = tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public func setResults(results: [String]) {
        self.results = results
    }
    
    public func clearResults() {
        results = []
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self),
                                 for: indexPath) as? PostTableViewCell
            else { return PostTableViewCell() }
        
        let string = results[indexPath.row]
        cell.configure(title: string)
        return cell
    }
}
