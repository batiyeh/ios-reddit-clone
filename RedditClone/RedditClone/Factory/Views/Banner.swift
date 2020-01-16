//
//  Banners.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/15/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public enum BannerType {
    case success
    case error
}

public class Banner: UIView {
    private let text: String
    private let type: BannerType
    
    public init(type: BannerType, text: String) {
        self.type = type
        self.text = text
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let banner = UIView()
    
    public var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private func setupView() {
        addSubview(banner)
        banner.addSubview(textLabel)
        
        textLabel.text = text
        textLabel.textColor = .white
        banner.backgroundColor = .red
        
        banner.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(25)
            make.top.equalToSuperview().offset(20)
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(10)
        }
    }
}
