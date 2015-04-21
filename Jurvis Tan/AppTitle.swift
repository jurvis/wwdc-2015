//
//  AppTitle.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 21/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class AppTitle: UIView {

    var containerView: UIView!
    var appTitleLabel: UILabel!
    var appSubtitleLabel: UILabel!
    var appIconView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let appIconSize: CGSize = CGSizeMake(150, 150)
        appIconView = UIImageView()
        appIconView.frame = CGRectMake(CGRectGetMaxX(self.bounds) - appIconSize.width, 0, appIconSize.width, appIconSize.height)
        
        appTitleLabel = UILabel(frame: CGRectMake(0, 0, self.bounds.size.width - appIconSize.width, 0))
        appTitleLabel.font = UIFont(name: "WhitneyHTF-Bold", size: 60)
        appTitleLabel.numberOfLines = 1
        appTitleLabel.minimumScaleFactor = 45 / 60;
        appTitleLabel.adjustsFontSizeToFitWidth = true
        appTitleLabel.textAlignment = NSTextAlignment.Left
        appTitleLabel.textColor = UIColor.greyTextColor()
        
        appSubtitleLabel = UILabel(frame: CGRectMake(appTitleLabel.frame.origin.x, CGRectGetMaxY(appTitleLabel.frame), 0, 0))
        appSubtitleLabel.numberOfLines = 0
        appSubtitleLabel.textAlignment = NSTextAlignment.Left
        appSubtitleLabel.font = UIFont(name: "WhitneyHTF-Book", size: 24)
        appSubtitleLabel.textColor = UIColor.greyTextColor()
        
        containerView = UIView(frame: CGRectMake(0, 0, self.frame.size.width - appIconView.frame.size.width, appTitleLabel.frame.size.height + appSubtitleLabel.frame.size.height))
        containerView.addSubview(appTitleLabel)
        containerView.addSubview(appSubtitleLabel)
        
        self.addSubview(containerView)
        self.addSubview(appIconView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        appTitleLabel.sizeToFit()
        appTitleLabel.frame = CGRectMake(appTitleLabel.frame.origin.x, appTitleLabel.frame.origin.y, self.bounds.size.width - appIconView.frame.size.width, appTitleLabel.frame.size.height)
        
        appSubtitleLabel.sizeToFit()
        appSubtitleLabel.frame = CGRectMake(0, CGRectGetMaxY(appTitleLabel.frame), self.frame.size.width - appIconView.frame.size.width, appSubtitleLabel.frame.size.height)
        
        var labelsHeight = appTitleLabel.frame.size.height + appSubtitleLabel.frame.size.height
        containerView.frame = CGRectMake(0, (self.frame.size.height - labelsHeight) / 2, containerView.frame.size.height, labelsHeight)
    }

}
