//
//  WebViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 19/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    let webSiteURL = NSURL(string: "http://jurvis.co")
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parentSize: CGSize = self.view.bounds.size
        let cardViewSize: CGSize = CGSizeMake(parentSize.width - 188.5, parentSize.height - 99.0)
        
        
        self.view.backgroundColor = UIColor.lightOrangeBackgroundColor()
        webView = UIWebView(frame: CGRectMake(0, 0, cardViewSize.width, cardViewSize.height))
        var request: NSURLRequest = NSURLRequest(URL: webSiteURL!)
        webView.loadRequest(request)
        
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
