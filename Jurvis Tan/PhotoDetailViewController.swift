//
//  PhotoDetailViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 18/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var prevCellRect: CGRect!
    var viewControllerIndex: Int!
    var imageURL: NSURL!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parentSize: CGSize = self.view.bounds.size
        let cardViewSize: CGSize = CGSizeMake(parentSize.width - 188.5, parentSize.height - 99.0)
        
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 921.6, 614.4))
        self.imageView.center = self.view.center
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        println(imageURL.URLString)
        self.imageView.setImageWithUrl(imageURL, placeHolderImage: nil)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissView")
        tapGestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.view.addSubview(self.imageView)
    }
    
    func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
