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
    
    private func setupBannerForType() {
        switch type {
        case .success:
            banner.backgroundColor = .green
        case .error:
            banner.backgroundColor = Factory.colors.error
        }
    }
    
    // Pardon my bad UI for this banner - didn't spend very much time on it!
    private func setupView() {
        addSubview(banner)
        banner.addSubview(textLabel)
        setupBannerForType()
        
        textLabel.text = text
        textLabel.textColor = .white
        banner.layer.cornerRadius = 5
        banner.layer.shadowColor = UIColor.black.cgColor
        banner.layer.shadowOpacity = 0.3
        banner.layer.shadowOffset = .zero
        banner.layer.shadowRadius = 3
        banner.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(10)
        }
    }
}

extension Banner {
    public func show(superview: UIView, dismissDuration: TimeInterval) {
        superview.addSubview(self)
        superview.bringSubviewToFront(self)
        superview.layoutIfNeeded()
        
        showBanner(superview: superview)
        
        DispatchQueue.dispatchToMainAsync {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, animations: {
                superview.layoutIfNeeded()
            }) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration) { [weak self] in
                    self?.dismiss()
                }
            }
        }
    }
    
    public func dismiss() {
        guard let superview = superview else { return }
        superview.layoutIfNeeded()
        hideBanner(superview: superview)
        DispatchQueue.dispatchToMainAsync {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, animations: {
                superview.layoutIfNeeded()
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    public func showBanner(superview: UIView) {
        DispatchQueue.dispatchToMainAsync { [weak self] in
            self?.snp.remakeConstraints { (make) in
                make.top.equalTo(superview.snp.top).inset(50)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(100)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    public func hideBanner(superview: UIView) {
        DispatchQueue.dispatchToMainAsync { [weak self] in
            self?.snp.remakeConstraints { (make) in
                make.bottom.equalTo(superview.snp.top)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(100)
                make.centerX.equalToSuperview()
            }
        }
    }
}
