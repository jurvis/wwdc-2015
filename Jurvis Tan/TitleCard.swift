//
//  TitleCard.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class TitleCard: UIView, UIDynamicItem {
    
    let imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        self.imageView  = UIImageView(image: UIImage(named: "profile"))
        super.init(coder:aDecoder)
    }
    
    override init(frame:CGRect) {
        self.imageView  = UIImageView(image: UIImage(named: "profile"))
        super.init(frame:frame)
        
        let imageWidthAndHeight: CGFloat = self.frame.size.height * 0.478
        self.imageView.frame = CGRectMake(0, 0, imageWidthAndHeight, imageWidthAndHeight)
        self.imageView.image = UIImage(named: "profile")
        
        let openSansRegularDict: NSDictionary = [
            NSFontAttributeName : UIFont(name: "OpenSans", size: 32.0)!,
        ]
        
        let openSansExtraboldDict: NSDictionary = [
            NSFontAttributeName : UIFont(name: "OpenSans-Extrabold", size: 32.0)!,
        ]
        
        let aAttrbString: NSMutableAttributedString = NSMutableAttributedString(string: "Hi, my name is ", attributes: openSansRegularDict as [NSObject : AnyObject])
        let bAttrbString: NSMutableAttributedString = NSMutableAttributedString(string: "Jurvis", attributes: openSansExtraboldDict as [NSObject : AnyObject])
        let cAttrbString: NSMutableAttributedString = NSMutableAttributedString(string: ", I’m a 17 year old iOS/Web Developer from Singapore.\n\nHere are some of my recent projects…", attributes: openSansRegularDict as [NSObject : AnyObject])
        
        let finalString:NSMutableAttributedString = NSMutableAttributedString()
        finalString.appendAttributedString(aAttrbString)
        finalString.appendAttributedString(bAttrbString)
        finalString.appendAttributedString(cAttrbString)
        
        
        let descriptionRect: CGRect = finalString.boundingRectWithSize(CGSizeMake(self.bounds.size.width-40, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), context: nil)
        
        let textDescription: UILabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(imageView.frame) + 35, self.frame.size.width, descriptionRect.size.height))
        textDescription.attributedText = finalString
        textDescription.textColor = UIColor.greyTextColor()
        textDescription.numberOfLines = 0
        
        self.addSubview(imageView)
        self.addSubview(textDescription)

    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
