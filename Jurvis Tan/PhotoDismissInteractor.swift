//
//  PhotoDismissInteractor.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 21/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoDismissInteractor: UIPercentDrivenInteractiveTransition, UIViewControllerInteractiveTransitioning {
    
    private var interactive = false
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    var presentedViewController: UIViewController! {
        didSet {
            self.panGestureRecognizer = UIPanGestureRecognizer()
            self.panGestureRecognizer.addTarget(self, action: "handlePan:")
            self.presentedViewController.view.addGestureRecognizer(self.panGestureRecognizer)
        }
    }
    
    func handlePan(pr: UIPanGestureRecognizer) {
        let translation = pr.translationInView(pr.view!)
        
        let d = translation.y / CGRectGetWidth(pr.view!.bounds) * 0.5
        
        switch pr.state {
        case UIGestureRecognizerState.Began:
            interactive = true
            self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
            break
            
        case UIGestureRecognizerState.Changed:
            self.updateInteractiveTransition(d)
            break
        default:
            self.interactive = false
            
            if d > 0.2 {
                self.finishInteractiveTransition()
            } else {
                self.cancelInteractiveTransition()
            }
        }
    }
}
