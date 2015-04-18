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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect = UIScreen.mainScreen().bounds
        let leftMargin: CGFloat = screenRect.size.width * 0.0546;
        
        self.view.backgroundColor = UIColor.lightOrangeBackgroundColor()
        self.containerView = TitleCard(frame: CGRectMake(leftMargin, screenRect.size.height * 0.207, screenRect.size.width * 0.534, screenRect.size.height * 0.439))
        
        let arrowView: UIImageView = UIImageView(image: UIImage(named: "line"))
        let arrowSize: CGSize = CGSizeMake(55, 27.5)
        arrowView.frame = CGRectMake((screenRect.size.width - arrowSize.width) / 2, screenRect.size.height - 30.5 - arrowSize.height, arrowSize.width, arrowSize.height)
        
        let swipeLabel: UILabel = UILabel(frame: CGRectMake(0, 0, 0, 0))
        swipeLabel.text = "Swipe Down"
        swipeLabel.font = UIFont(name: "OpenSans-Semibold", size: 20)
        swipeLabel.textColor = UIColor.subOrangeTextColor()
        swipeLabel.sizeToFit()
        swipeLabel.frame.origin = CGPointMake((screenRect.size.width - swipeLabel.frame.size.width) / 2, CGRectGetMinY(arrowView.frame) - 17.5 - swipeLabel.frame.size.height)
        
        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, screenRect.size.width * 2, screenRect.size.width * 2))
        self.backgroundImageView.image = UIImage(named: "title_background")
        self.backgroundImageView.center = CGPointMake(902, 430)
        self.backgroundImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * (-30/180))
        
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(swipeLabel)
        self.view.addSubview(arrowView)
        self.view.addSubview(self.containerView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"adjustBackgroundImage:", name: "scrollViewScrolled", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func adjustBackgroundImage(notification: NSNotification) {
        var y = notification.object as! CGFloat
//        var imageFrame : CGRect =  self.backgroundImageView.frame
//        imageFrame.origin.y = y / 2
//        self.backgroundImageView.frame = imageFrame
        
        
        var titleCardFrame: CGRect = self.containerView.frame
    
        
    }
}
