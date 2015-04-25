//
//  HomeViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var containerView: TitleCard! = nil
    var backgroundImageView: UIImageView!
    var arrowImageView: UIImageView!
    var swipeLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.runFloatAnimationOnView(swipeLabel, withDisplacement: 5.0)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect = UIScreen.mainScreen().bounds
        let leftMargin: CGFloat = screenRect.size.width * 0.0546;
        
        self.view.backgroundColor = UIColor.lightOrangeBackgroundColor()
        self.containerView = TitleCard(frame: CGRectMake(leftMargin, screenRect.size.height * 0.207, screenRect.size.width * 0.534, screenRect.size.height * 0.439))
        
        arrowImageView = UIImageView(image: UIImage(named: "line"))
        let arrowSize: CGSize = CGSizeMake(55, 27.5)
        arrowImageView.frame = CGRectMake((screenRect.size.width - arrowSize.width) / 2, screenRect.size.height - 30.5 - arrowSize.height, arrowSize.width, arrowSize.height)
        
        swipeLabel = UILabel(frame: CGRectMake(0, 0, 0, 0))
        swipeLabel.text = "Swipe Up"
        swipeLabel.font = UIFont(name: "WhitneyHTF-SemiBold", size: 20)
        swipeLabel.textColor = UIColor.subOrangeTextColor()
        swipeLabel.sizeToFit()
        swipeLabel.frame.origin = CGPointMake((screenRect.size.width - swipeLabel.frame.size.width) / 2, CGRectGetMinY(arrowImageView.frame) - 12 - swipeLabel.frame.size.height)
        
        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, screenRect.size.width * 2, screenRect.size.width * 2))
        self.backgroundImageView.image = UIImage(named: "title_background")
        self.backgroundImageView.center = CGPointMake(902, 430)
        self.backgroundImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * (-30/180))
        

        if !Reachability.isConnectedToNetwork() {
            var alert = UIAlertController(title: "Turn On Wifi/Cellular", message: "This app requires data to display some photos correctly!", preferredStyle: UIAlertControllerStyle.Alert)
            
            var alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(swipeLabel)
        self.view.addSubview(arrowImageView)
        self.view.addSubview(self.containerView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"adjustBackgroundImage:", name: "scrollViewScrolled", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    func runFloatAnimationOnView(view: UIView, withDisplacement displacement: CGFloat) {
        let fromValue = view.layer.frame.origin.y
        let toValue = view.layer.frame.origin.y - displacement
        
        
        let floatAnimation: CABasicAnimation
        floatAnimation = CABasicAnimation(keyPath: "position.y")
        floatAnimation.fromValue = fromValue
        floatAnimation.toValue = toValue
        floatAnimation.autoreverses = true
        floatAnimation.duration = 1.5
        floatAnimation.repeatCount = Float.infinity
        view.layer.addAnimation(floatAnimation, forKey: "floatAnimation")
    }
    
    
    func adjustBackgroundImage(notification: NSNotification) {
        var y = notification.object as! CGFloat
//        var imageFrame : CGRect =  self.backgroundImageView.frame
//        imageFrame.origin.y = y / 2
//        self.backgroundImageView.frame = imageFrame
        
        
        var titleCardFrame: CGRect = self.containerView.frame
    
        
    }
}
