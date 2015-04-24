//
//  TitleView.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 24/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    var titleLabel: UILabel!
    var titleIcon: UIImageView!
    
    
    init(title: String, image: UIImage, frame: CGRect) {
        super.init(frame: frame)
        
        
        var imageWidth = ( frame.size.height/image.size.height ) * image.size.width
        titleIcon = UIImageView(frame: CGRectMake(0, 0, imageWidth, frame.size.height))
        titleIcon.image = image
        
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(titleIcon.frame) + 15, 0, 0, 0))
        titleLabel.font = UIFont(name: "WhitneyHTF-Bold", size: 32)
        titleLabel.textColor = UIColor.greyTextColor()
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPointMake(CGRectGetMaxX(titleIcon.frame) + 15, ( self.frame.size.height - titleLabel.frame.size.height ) / 2)
        
        self.addSubview(titleIcon)
        self.addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeToFitSubviews() {
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        for v in self.subviews {
            var fw = v.frame.origin.x + v.frame.size.width
            var fh = v.frame.origin.y + v.frame.size.height
            
            w = max(fw, w)
            h = max(fh,h)
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
