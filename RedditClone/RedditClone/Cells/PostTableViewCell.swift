//
//  PostTableViewCell.swift
//  RedditClone
//
//  Created by Atiyeh, Brian (B.) on 9/10/19.
//  Copyright © 2019 Brian Atiyeh. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

class PostTableViewCell: UITableViewCell {
    public var tapped = PublishSubject<UITapGestureRecognizer>()
    private let verticalMargin: CGFloat = 25.0
    private let horizontalMargin: CGFloat = 20.0
    private let disposeBag = DisposeBag()
    
    lazy var view = UIView()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 4
        label.textColor = .black
        return label
    }()
    
    lazy var subredditLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var thumbnailWrapper: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = true;
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var verticalStackView: UIStackView = {
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
    
    public func configure(post: SinglePostModel, isTappable: Bool = true) {
        titleLabel.text = post.title
        subredditLabel.text = "r/\(post.subreddit)"
        
        if isTappable {
            addTapGesture()
        }
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer()
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        tap.rx.event.bind(to: tapped).disposed(by: disposeBag)
    }
    
    private func layoutView() {
        thumbnailWrapper.addSubview(thumbnail)
        thumbnail.center = CGPoint(x: thumbnailWrapper.bounds.size.width  / 2,
                                   y: thumbnailWrapper.bounds.size.height / 2)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subredditLabel)
        
        view.addSubview(thumbnailWrapper)
        view.addSubview(verticalStackView)
        contentView.addSubview(view)
        
        view.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalMargin)
            make.trailing.equalToSuperview().inset(horizontalMargin)
            make.top.equalToSuperview().offset(verticalMargin)
            make.bottom.equalToSuperview().inset(verticalMargin)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        subredditLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.leading.equalToSuperview()
        }
        
        thumbnailWrapper.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
        
        thumbnail.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        verticalStackView.snp.remakeConstraints { make in
            make.leading.equalTo(thumbnailWrapper.snp.trailing).offset(15)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
