//
//  CompanyView.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 16/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class CompanyView: UIView {

    var positionTitleLabel: UILabel!
    var companyNameAndDurationLabel: UILabel!
    var jobDescriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        self.positionTitleLabel = UILabel()
        self.companyNameAndDurationLabel = UILabel()
        self.jobDescriptionLabel = UILabel()
        super.init(frame: frame)
        
        self.positionTitleLabel.frame = CGRectMake(0, 0, 0, 0)
        self.positionTitleLabel.font = UIFont(name: "OpenSans-Semibold", size: 32)
        self.positionTitleLabel.textColor = UIColor.greyTextColor()
        
        self.companyNameAndDurationLabel.frame = CGRectMake(0, CGRectGetMaxY(self.positionTitleLabel.frame), 0, 0)
        self.companyNameAndDurationLabel.font = UIFont(name: "OpenSans-Semibold", size: 21)
        self.companyNameAndDurationLabel.textColor = UIColor.subGreyTextColor()
        
        
        self.jobDescriptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.companyNameAndDurationLabel.frame),frame.size.width, 0)
        self.jobDescriptionLabel.font = UIFont(name: "OpenSans", size: 21)
        self.jobDescriptionLabel.textColor = UIColor.subGreyTextColor()
        self.jobDescriptionLabel.numberOfLines = 0
        self.jobDescriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.addSubview(self.positionTitleLabel)
        self.addSubview(self.companyNameAndDurationLabel)
        self.addSubview(self.jobDescriptionLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.positionTitleLabel.sizeToFit()
        self.companyNameAndDurationLabel.sizeToFit()
        self.companyNameAndDurationLabel.frame.origin = CGPointMake(0, CGRectGetMaxY(self.positionTitleLabel.frame))
        
        let descriptionTextLabelRect = self.jobDescriptionLabel.attributedText.boundingRectWithSize(CGSizeMake(self.frame.size.width, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), context:nil)
        self.jobDescriptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.companyNameAndDurationLabel.frame), self.frame.size.width, descriptionTextLabelRect.size.height)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
