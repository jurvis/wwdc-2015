//
//  PhotoPresentAnimator.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 19/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromContainerViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ContainerViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! PhotoDetailViewController
        
        let fromViewController = fromContainerViewController.viewControllerAtIndex(toViewController.viewControllerIndex)
        let containerView = transitionContext.containerView()
        
        
        var selectedImageView = fromContainerViewController.view.resizableSnapshotViewFromRect(toViewController.prevCellRect, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        selectedImageView.frame = toViewController.prevCellRect
        
        containerView.addSubview(selectedImageView)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            selectedImageView.frame = toViewController.imageView.frame
        }) { (finished) -> Void in
            fromViewController.view .removeFromSuperview()
            selectedImageView.removeFromSuperview()
            containerView.addSubview(toViewController.view)
            transitionContext.completeTransition(finished)
        }
        
    }
}
