//
//  PostsView.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public class PostsView: UIView {
    public var tableView = UITableView()
    public var searchTextField = UITextField()
    private let horizontalMargin: CGFloat = 20.0
    
    public init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField() {
        let lightGray = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        let darkGray = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        
        addSubview(searchTextField)
        searchTextField.backgroundColor = lightGray
        searchTextField.layer.cornerRadius = 10
        searchTextField.placeholder = "Search"
        searchTextField.setPaddingPoints(left: 10, right: nil)
        if #available(iOS 13.0, *) {
            searchTextField.setLeftImage(image: UIImage(systemName: "magnifyingglass")!)
            searchTextField.leftView?.tintColor = darkGray
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().inset(horizontalMargin)
            make.top.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.rowHeight = UITableView.automaticDimension
    }
}
