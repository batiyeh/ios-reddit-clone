//
//  PostTableViewCell.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class PostTableViewCell: UITableViewCell {
    private let defaultVerticalMarginValue: CGFloat = 25.0
    private let defaultHorizontalMarginValue: CGFloat = 8.0
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    public lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(title: String) {
        self.accessibilityIdentifier = title
        titleLabel.text = title
    }
    
    private func layoutView() {
        verticalStackView.addArrangedSubview(titleLabel)
        contentView.addSubview(verticalStackView)
        
        verticalStackView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(defaultVerticalMarginValue)
            make.trailing.equalToSuperview().inset(defaultVerticalMarginValue)
            make.top.equalToSuperview().offset(defaultVerticalMarginValue)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview()
        }
    }
}
