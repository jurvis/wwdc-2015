//
//  PersonalWorkViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PersonalWorkViewController: BaseViewController {
    let detailTransitioningDelegate: CardDetailPresentationManager = CardDetailPresentationManager()
    
    var imageName: String?
    var appVideoUrl: String!
    var app: PersonalApp!
    var applicationDetail: UIView!
    var applicationTitle: AppTitle!
    var appDescriptionTextView: UITextView!
    var applicationImageView: UIImageView!
    let screenRect: CGRect  = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        self.applicationImageView = UIImageView()
        super.viewDidLoad()
        
        let screenRect: CGRect  = UIScreen.mainScreen().bounds
        
        let applicationDetailHeight: CGFloat = screenRect.size.height * 0.677
        
        applicationTitle = AppTitle(frame:  CGRectMake(0, 0, screenRect.size.width * 0.424, 150))
        applicationTitle.appTitleLabel.text = app.title
        applicationTitle.appSubtitleLabel.text = app.subtitle
        applicationTitle.appIconView.image = app.appIcon
        
        appDescriptionTextView = UITextView(frame: CGRectMake(0, CGRectGetMaxY(applicationTitle.frame) + 25, applicationTitle.frame.size.width, 0))
        appDescriptionTextView.backgroundColor = UIColor.clearColor()
        appDescriptionTextView.selectable = false
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7;
        let attrb: NSDictionary = [NSFontAttributeName: UIFont(name: "Mercury-TextG1Roman", size: 17.5)!,
            NSParagraphStyleAttributeName: paragraphStyle]
        appDescriptionTextView.attributedText = NSAttributedString(string: app.appDescription, attributes: attrb as [NSObject : AnyObject])

        let descriptionText: NSString = app.appDescription as NSString
        let descriptionCellRect: CGRect = descriptionText.boundingRectWithSize(CGSizeMake(appDescriptionTextView.frame.size.width - 40, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: attrb as [NSObject : AnyObject], context: nil)
        appDescriptionTextView.frame = CGRectMake(appDescriptionTextView.frame.origin.x, appDescriptionTextView.frame.origin.y, applicationTitle.frame.size.width, descriptionCellRect.size.height + (18 * 1.125))
        
        applicationDetail = UIView(frame: CGRectUnion(applicationTitle.frame, appDescriptionTextView.frame))
        
        if (appVideoUrl != nil) {
            var videoButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            
            videoButton.setBackgroundImage(UIImage(named: "watch-video-btn"), forState: UIControlState.Normal)
            videoButton.setBackgroundImage(UIImage(named: "watch-video-btn-highlighted"), forState: UIControlState.Highlighted)
            videoButton.addTarget(self, action: "watchVideo", forControlEvents: UIControlEvents.TouchUpInside)
            
            videoButton.frame = CGRectMake((applicationDetail.bounds.width - 232) / 2, CGRectGetMaxY(appDescriptionTextView.frame), 232, 44)
            
            applicationDetail.frame = CGRectUnion(applicationDetail.frame, videoButton.frame)
            applicationDetail.addSubview(videoButton)
        }
        
        applicationDetail.addSubview(applicationTitle)
        applicationDetail.addSubview(appDescriptionTextView)
        applicationDetail.frame.origin = CGPointMake(screenRect.size.width * 0.47, ( screenRect.size.height - applicationDetail.frame.size.height ) / 2)
 
        
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
            let image: UIImage = UIImage(named: self.imageName!)!
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.applicationImageView.image = image
                
            })
        })
        
        applicationImageView.frame = CGRectMake(-360, ( screenRect.size.height - 582.5 ) / 2, 360, 582.5)
        
        applicationDetail.alpha = 0.0;
        applicationDetail.transform = CGAffineTransformMakeTranslation(0, 10);
        

        self.view.addSubview(applicationDetail)
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
            self.applicationImageView.frame = CGRectMake(screenRect.size.width * 0.07, self.applicationImageView.frame.origin.y, 360, 582.5)

        }, completion: nil)



        
    }
    
    override func   viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scrollViewScrolled", object: nil)
    }

    func watchVideo() {
        var videoController = VideoViewController()
        videoController.transitioningDelegate = detailTransitioningDelegate
        videoController.modalPresentationStyle = .Custom
        videoController.videoUrl = self.appVideoUrl
        
        self.presentViewController(videoController, animated: true, completion: nil)
    }
    
    func viewExiting(notification: NSNotification){
        var y = notification.object as! CGFloat
        var applicationImageViewFromFrame: CGRect =  self.applicationImageView.frame
        
        applicationImageViewFromFrame.origin.x = -abs(y) * sin(abs(y)/(screenRect.size.height*2) * CGFloat(M_PI)) + screenRect.size.width*0.07;
        
        self.applicationImageView.frame = applicationImageViewFromFrame
        self.applicationDetail.alpha =  1 - (abs(y) / self.view.bounds.height)
        

    }
    
}
