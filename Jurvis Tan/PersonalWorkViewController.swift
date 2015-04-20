//
//  PersonalWorkViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PersonalWorkViewController: BaseViewController {
    
    var imageName: String?
    var app: PersonalApp!
    var applicationDetail: AppView!
    var applicationImageView: UIImageView!
    let screenRect: CGRect  = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        self.applicationDetail = AppView()
        self.applicationImageView = UIImageView()
        super.viewDidLoad()
        
        let screenRect: CGRect  = UIScreen.mainScreen().bounds
        
        let applicationDetailHeight: CGFloat = screenRect.size.height * 0.677
        self.applicationDetail  = AppView(frame: CGRectMake(screenRect.size.width * 0.473, (screenRect.size.height - applicationDetailHeight) / 2, screenRect.size.width * 0.424, applicationDetailHeight))
        
        self.applicationDetail.titleLabel.text = app.title
        self.applicationDetail.subtitleLabel.text = app.subtitle
        self.applicationDetail.appIconView.image = app.appIcon
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7;
        let attrb: NSDictionary = [NSFontAttributeName: UIFont(name: "GentiumBookBasic", size: 18)!,
            NSParagraphStyleAttributeName: paragraphStyle]
        self.applicationDetail.appDescriptionTextView.attributedText = NSAttributedString(string: app.appDescription, attributes: attrb as [NSObject : AnyObject])
        
        let descriptionText: NSString = app.appDescription as NSString
        let descriptionCellRect: CGRect = descriptionText.boundingRectWithSize(CGSizeMake(self.view.frame.size.width - 40, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: attrb as [NSObject : AnyObject], context: nil)
        self.applicationDetail.appDescriptionTextView.frame.size = CGSizeMake(self.applicationDetail.frame.size.width, self.applicationDetail.frame.height - self.applicationDetail.frame.origin.y)
        
        self.applicationImageView.frame = CGRectMake(-360, screenRect.size.height * 0.169, 360, 582.5)
        
        self.applicationDetail.alpha = 0.0;
        self.applicationDetail.transform = CGAffineTransformMakeTranslation(0, 10);
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
            let image: UIImage = UIImage(named: self.imageName!)!
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.applicationImageView.image = image
                
            })
        })
        

        
        self.view.addSubview(self.applicationImageView)
        self.view.addSubview(self.applicationDetail)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let screenRect: CGRect  = UIScreen.mainScreen().bounds
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"viewExiting:", name: "scrollViewScrolled", object: nil)

        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.applicationDetail.alpha = 1.0
            self.applicationDetail.transform = CGAffineTransformMakeTranslation(0, -10)
        })
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.applicationImageView.frame = CGRectMake(screenRect.size.width * 0.07, screenRect.size.height * 0.169, 360, 582.5)

        }, completion: nil)



        
    }
    
    override func   viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scrollViewScrolled", object: nil)
    }

    func viewExiting(notification: NSNotification){
        var y = notification.object as! CGFloat
        var applicationImageViewFromFrame: CGRect =  self.applicationImageView.frame
        
        applicationImageViewFromFrame.origin.x = -abs(y) * sin(abs(y)/(screenRect.size.height*2) * CGFloat(M_PI)) + screenRect.size.width*0.07;
        
        self.applicationImageView.frame = applicationImageViewFromFrame
        self.applicationDetail.alpha =  1 - (abs(y) / self.view.bounds.height)
        

    }
    
}
