//
//  CardDetailPresentationController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 17/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit
import AVFoundation

class CardDetailPresentationController: UIPresentationController {
    var presentSound: SystemSoundID = 0
    var dismissSound: SystemSoundID = 1
    var dimmingView: UIView!

    
    override init(presentedViewController: UIViewController!, presentingViewController: UIViewController!) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        setupDimmingView()
        setUpAudioEffects()
    }
    
    func setupDimmingView() {
        dimmingView = UIView(frame: presentingViewController.view.bounds)
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = dimmingView.bounds
        visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        dimmingView.addSubview(visualEffectView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dimmingViewTapped:")
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setUpAudioEffects() {
        let soundPath = NSBundle.mainBundle().pathForResource("Complete", ofType: "wav")
        var url = NSURL.fileURLWithPath(soundPath!)
        AudioServicesCreateSystemSoundID(url as! CFURL, &self.presentSound)
        
        let soundPath2 = NSBundle.mainBundle().pathForResource("Close The Window", ofType: "wav")
        var url2 = NSURL.fileURLWithPath(soundPath2!)
        AudioServicesCreateSystemSoundID(url2 as! CFURL, &self.dismissSound)
    }
    
    func dimmingViewTapped(tapRecognizer: UITapGestureRecognizer) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView
        let presentedViewController = self.presentedViewController
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        
        AudioServicesPlaySystemSound(self.presentSound)
        
        containerView.insertSubview(dimmingView, atIndex: 0)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coordinatorContext) -> Void in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        AudioServicesPlaySystemSound(self.dismissSound)
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (coordinatorContext) -> Void in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView.bounds
        presentedView().frame = frameOfPresentedViewInContainerView()
    }
    
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSizeMake(parentSize.width - 188.5, parentSize.height - 99.0)
    }
    
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var presentedViewFrame = CGRectZero
        let containerBounds = containerView.bounds
        
        let contentContainer = presentedViewController
        presentedViewFrame.size = sizeForChildContentContainer(contentContainer, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = 188.5 / 2
        presentedViewFrame.origin.y = 99.0 / 2
        
        return presentedViewFrame
    }
}
