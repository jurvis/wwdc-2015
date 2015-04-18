//
//  HackathonCard.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 17/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class HackathonCard: UIView {
    let descriptionTextWidth: CGFloat
    
    var titleLabel: UILabel!
    var descriptionTextView: UITextView!
    
    
    override init(frame: CGRect) {
        descriptionTextWidth = frame.size.width * 0.7
        super.init(frame: frame)
        titleLabel = UILabel(frame: CGRectMake(28, 0, 0, 0))
        titleLabel.font = UIFont(name: "OpenSans-Semibold", size: 25)
        
        descriptionTextView = UITextView(frame: CGRectMake(28, CGRectGetMaxY(titleLabel.frame), descriptionTextWidth, 188))
        self.descriptionTextView.selectable = false
        self.descriptionTextView.textContainer.lineFragmentPadding = 0
        
        self.addSubview(titleLabel)
        self.addSubview(descriptionTextView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        
        
        let descriptionTextLabelRect = self.descriptionTextView.attributedText.boundingRectWithSize(CGSizeMake(descriptionTextWidth, 10000), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), context:nil)
        self.descriptionTextView.frame  = CGRectMake(28, CGRectGetMaxY(titleLabel.frame), descriptionTextWidth, ceil(descriptionTextLabelRect.size.height) + (18 * 1.125))

    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
