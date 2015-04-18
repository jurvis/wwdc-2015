//
//  AppView.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class AppView: UIView {
    
    let titleLabel: UILabel!
    let subtitleLabel: UILabel!
    let appDescriptionTextView: UITextView!
    let appIconView: UIImageView!

    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        self.subtitleLabel = UILabel()
        self.appDescriptionTextView = UITextView()
        self.appIconView = UIImageView()
        super.init(frame: frame)
        
        let appIconSize: CGSize = CGSizeMake(150, 150)
        self.appIconView.frame = CGRectMake(CGRectGetMaxX(self.bounds) - appIconSize.width, 0, appIconSize.width, appIconSize.height)
        
        self.titleLabel.frame = CGRectMake(0, 0, CGRectGetMinX(self.appIconView.frame) - 25, 22)
        self.titleLabel.font = UIFont(name: "OpenSans-Extrabold", size: 60)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = NSTextAlignment.Left
        self.titleLabel.textColor = UIColor.greyTextColor()
        
        self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.appIconView.frame) + 5, self.frame.size.width, 0)
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.textAlignment = NSTextAlignment.Right
        self.subtitleLabel.font = UIFont(name: "OpenSans", size: 37)
        self.subtitleLabel.textColor = UIColor.greyTextColor()

        self.appDescriptionTextView.frame = CGRectMake(0, CGRectGetMaxY(self.subtitleLabel.frame) + 22.5, self.bounds.size.width, 0)
        self.appDescriptionTextView.font = UIFont(name: "GentiumBookBasic", size: 18)!
        self.appDescriptionTextView.backgroundColor = UIColor.clearColor()
        self.appDescriptionTextView.selectable = false
        
        self.addSubview(self.appDescriptionTextView)
        self.addSubview(self.appIconView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        
    }
    
    override func layoutSubviews() {
        self.titleLabel.sizeToFit()
        self.titleLabel.frame = CGRectMake(0, CGRectGetMidY(self.appIconView.frame) - (self.titleLabel.frame.size.height / 2), CGRectGetMinX(self.appIconView.frame) - 25, self.titleLabel.frame.size.height)
        
        self.subtitleLabel.sizeToFit()
        self.subtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.appIconView.frame) + 5, self.frame.size.width, self.subtitleLabel.frame.size.height)
        
        self.appDescriptionTextView.frame.origin = CGPointMake(0, CGRectGetMaxY(self.subtitleLabel.frame) + 6)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.titleLabel = UILabel()
        self.subtitleLabel = UILabel()
        self.appDescriptionTextView = UITextView()
        self.appIconView = UIImageView()
        super.init(coder:aDecoder)
    }
}
