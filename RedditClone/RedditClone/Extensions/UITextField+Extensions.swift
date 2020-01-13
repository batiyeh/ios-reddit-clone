//
//  UITextField+Extensions.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/11/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

extension UITextField {
    func setPaddingPoints(left: CGFloat?, right: CGFloat?){
        if let leftPadding = left {
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.size.height))
            
            self.leftView = leftPaddingView
            self.leftViewMode = .always
        }
        
        if let rightPadding = right {
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.size.height))
            
            self.rightView = rightPaddingView
            self.rightViewMode = .always
        }
    }
    
    func setLeftImage(image: UIImage) {
        let containerView = UIView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        imageView.image = image
        
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(15)
        }
        self.leftView = containerView;
        self.leftViewMode = .always
    }
}
