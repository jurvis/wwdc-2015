//
//  FinalViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 19/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class FinalViewController: BaseViewController {
    let detailTransitioningDelegate: CardDetailPresentationManager = CardDetailPresentationManager()
    
    var thankYouLabel: UILabel!
    var underlineView: UIView!
    var bodyTextView: UITextView!
    var webButton: UIButton!
    var wwdcImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greyTextColor()
        
        thankYouLabel = UILabel()
        thankYouLabel.text = "Thank You".uppercaseString
        thankYouLabel.textColor = UIColor.lightOrangeBackgroundColor()
        thankYouLabel.font = UIFont(name: "OpenSans-Extrabold", size: 60)
        thankYouLabel.sizeToFit()
        thankYouLabel.frame.origin = CGPointMake(50, 50)
        
        underlineView = UIView(frame: CGRectMake(thankYouLabel.frame.origin.x, CGRectGetMaxY(thankYouLabel.frame), thankYouLabel.frame.size.width, 1.5))
        underlineView.backgroundColor = UIColor.lightOrangeBackgroundColor()
        
        wwdcImage = UIImageView(image: UIImage(named: "wwdc_logo"))
        wwdcImage.frame = CGRectMake(-wwdcImage.image!.size.width, CGRectGetMaxY(underlineView.frame) + 30, wwdcImage.image!.size.width, wwdcImage.image!.size.height)
        
        bodyTextView = UITextView()
        bodyTextView.backgroundColor = UIColor.clearColor()
        bodyTextView.selectable = false
        let bodyTextParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        bodyTextParaStyle.lineSpacing = 9;
        bodyTextView.attributedText = NSAttributedString(string:"Yes, you. For being part of Apple and making all of this and WWDC possible.\n\nApple is my source of inspiration for this road I tread, ever since I got my first Macbook when I was 13. It was the first computer I wrote my first computer program on and I’ve never stopped writing code ever since.\n\nApple has also contributed to my appreciation on the balance of design, aesthetic and technology. Not just limited to programming, Apple has left its influence on various aspects of my life.\n\nIt would be a great honour to be given the opportunity to go to WWDC to meet new iOS developers my age and beyond, to further inspire my love for travelling deeper into the realms of iOS Development and finally, to push ahead and build meaningful experiences and apps for the community.\n\nI hope to see you there.",
            attributes: [
                NSFontAttributeName: UIFont(name: "GentiumBookBasic", size: 19)!,
                NSParagraphStyleAttributeName: bodyTextParaStyle,
                NSForegroundColorAttributeName: UIColor.lightOrangeBackgroundColor()
            ])
        bodyTextView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        
        var boundingSize = bodyTextView.attributedText.boundingRectWithSize(CGSizeMake(self.view.frame.size.width * 0.50, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), context:nil)
        bodyTextView.frame = CGRectMake(CGRectGetMaxX(thankYouLabel.frame) + 60, thankYouLabel.frame.origin.y, boundingSize.width, boundingSize.height + (18 * 1.125 * 4))
        bodyTextView.transform = CGAffineTransformMakeTranslation(0, -10)
        bodyTextView.alpha = 0.0
        
        webButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        webButton.setImage(UIImage(named: "web_btn"), forState: UIControlState.Normal)
        webButton.setImage(UIImage(named: "web_btn_selected"), forState: UIControlState.Highlighted)
        webButton.addTarget(self, action: "openWebSite", forControlEvents: UIControlEvents.TouchUpInside)
        webButton.frame = CGRectMake(CGRectGetMaxX(bodyTextView.frame) - 127.5, CGRectGetMaxY(bodyTextView.frame) - 35.5, 127.5, 35.5)
        
        
        self.view.addSubview(thankYouLabel)
        self.view.addSubview(underlineView)
        self.view.addSubview(wwdcImage)
        self.view.addSubview(bodyTextView)
        self.view.addSubview(webButton)
    }
    
    func openWebSite() {
        var webViewController = WebViewController()
        webViewController.transitioningDelegate = detailTransitioningDelegate
        webViewController.modalPresentationStyle = .Custom
        self.presentViewController(webViewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"viewExiting:", name: "scrollViewScrolled", object: nil)
        
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bodyTextView.alpha = 1.0
            self.bodyTextView.transform = CGAffineTransformMakeTranslation(0, -10)
        })
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.wwdcImage.frame = CGRectMake(0, CGRectGetMaxY(self.underlineView.frame) + 30, self.wwdcImage.image!.size.width, self.wwdcImage.image!.size.height)
            }, completion: nil)
    }
    
    override func   viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scrollViewScrolled", object: nil)
    }
    
    func viewExiting(notification: NSNotification){
        let screenRect = UIScreen.mainScreen().bounds
        var y = notification.object as! CGFloat
        var wwdcImageViewFromFrame: CGRect =  self.wwdcImage.frame
        
        wwdcImageViewFromFrame.origin.x = -abs(y) * sin(abs(y)/(screenRect.size.height*2) * CGFloat(M_PI));
        
        self.wwdcImage.frame = wwdcImageViewFromFrame
        self.bodyTextView.alpha =  1 - (abs(y) / self.view.bounds.height)
        
        
    }

}
