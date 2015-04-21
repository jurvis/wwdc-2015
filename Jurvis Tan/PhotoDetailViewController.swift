//
//  PhotoDetailViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 18/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var prevCellRect: CGRect!
    var viewControllerIndex: Int!
    var imageURL: NSURL!
    var placeHolderImage: UIImage!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parentSize: CGSize = self.view.bounds.size
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 921.6, 614.4))
        self.imageView.center = self.view.center
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.setImageWithUrl(imageURL, placeHolderImage: placeHolderImage)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissView")
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.view.addSubview(self.imageView)
    }
    
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

}
