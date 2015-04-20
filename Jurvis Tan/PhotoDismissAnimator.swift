//
//  PhotoDismissAnimator.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 19/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! PhotoDetailViewController
        let containerToViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ContainerViewController
        
        let toViewController = containerToViewController.viewControllerAtIndex(fromViewController.viewControllerIndex)
        let containerView = transitionContext.containerView()
        
        var imageView = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.imageView.frame, afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        imageView.frame = fromViewController.imageView.frame
        
        containerView.addSubview(imageView)
        fromViewController.view.removeFromSuperview()
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            imageView.frame = fromViewController.prevCellRect
        }) { (finished) -> Void in
            containerView.addSubview(toViewController.view)
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}