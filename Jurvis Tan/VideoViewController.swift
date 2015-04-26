//
//  VideoViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 24/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    var videoUrl: String!
    var videoPlayer: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        let parentSize: CGSize = self.view.bounds.size
        let cardViewSize: CGSize = CGSizeMake(parentSize.width - 188.5, parentSize.height - 99.0)
        
        var videoPlayerHeight = (9/16) * cardViewSize.width
        self.videoPlayer = YTPlayerView(frame: CGRectMake(0, 0, cardViewSize.width, videoPlayerHeight))
        self.videoPlayer.frame.origin = CGPointMake(0, (cardViewSize.height - videoPlayerHeight) / 2)
        self.videoPlayer.loadWithVideoId("n-qDcaVnL_4")

        self.view.addSubview(self.videoPlayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
