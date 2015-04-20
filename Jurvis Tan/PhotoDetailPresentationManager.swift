//
//  PhotoDetailPresentationManager.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 19/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoDetailPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    
    private var interactive = false
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PhotoPresentAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PhotoDismissAnimator()
    }

}
