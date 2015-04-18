//
//  CardDetailViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 17/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController, UIScrollViewDelegate {
    var hackathonProjects : [String : PersonalApp]!

    var containerView: UIView!
    var detailScrollView: UIScrollView!
    var imageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parentSize: CGSize = self.view.bounds.size
        let cardViewSize: CGSize = CGSizeMake(parentSize.width - 188.5, parentSize.height - 99.0)
        containerView = UIView(frame: CGRectMake(0, 0, cardViewSize.width, cardViewSize.height))
        containerView.backgroundColor = UIColor.whiteColor()
        
        let imageScrollRect: CGRect  = CGRectMake(0, 0, cardViewSize.width, cardViewSize.height * 0.581)
        var relayPlayHeroImageView: UIImageView = UIImageView(image:UIImage(named: "relayplay_hero"))
        relayPlayHeroImageView.frame = imageScrollRect
        var multitudeHeroImageView: UIImageView = UIImageView(image: UIImage(named: "multitude_hero"))
        multitudeHeroImageView.frame = CGRectMake(relayPlayHeroImageView.frame.size.width, 0, imageScrollRect.size.width, imageScrollRect.size.height)
        imageScrollView = UIScrollView(frame: imageScrollRect)
        imageScrollView.contentSize = CGSizeMake(imageScrollRect.width * 2, imageScrollRect.height)
        imageScrollView.pagingEnabled = true
        imageScrollView.delegate = self
        imageScrollView.addSubview(relayPlayHeroImageView)
        imageScrollView.addSubview(multitudeHeroImageView)
        
        let detailScrollViewRect: CGRect = CGRectMake(0, imageScrollRect.height, cardViewSize.width, cardViewSize.height - CGRectGetMaxY(imageScrollRect))
        detailScrollView = UIScrollView(frame: detailScrollViewRect)
        detailScrollView.contentSize = CGSizeMake(cardViewSize.width * 2, detailScrollViewRect.height)
        detailScrollView.pagingEnabled = true
        detailScrollView.scrollEnabled = false
        detailScrollView.backgroundColor = UIColor.greenColor()
       
        var relayPlayCardView: HackathonCard = HackathonCard(frame: CGRectMake(0, 15, cardViewSize.width, detailScrollView.bounds.size.height))
        relayPlayCardView.backgroundColor = UIColor.redColor()
        relayPlayCardView.titleLabel.text = hackathonProjects["RelayPlay"]?.subtitle
        
        let relayPlayDescParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        relayPlayDescParaStyle.lineSpacing = 5;
        relayPlayCardView.descriptionTextView.attributedText = NSAttributedString(string: hackathonProjects["RelayPlay"]!.appDescription!,
            attributes: [
                NSFontAttributeName: UIFont(name: "GentiumBookBasic", size: 18)!,
                NSParagraphStyleAttributeName: relayPlayDescParaStyle
            ])
        
        var multitudeCardView: HackathonCard = HackathonCard(frame: CGRectMake(CGRectGetMaxX(relayPlayCardView.frame), 15, cardViewSize.width, detailScrollView.bounds.size.height))
        multitudeCardView.titleLabel.text = hackathonProjects["Multitude"]?.subtitle
        multitudeCardView.backgroundColor = UIColor.blueColor()

        let multitudeDescParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        multitudeDescParaStyle.lineSpacing = 5;
        multitudeCardView.descriptionTextView.attributedText = NSAttributedString(string: hackathonProjects["Multitude"]!.appDescription!,
            attributes: [
                NSFontAttributeName: UIFont(name: "GentiumBookBasic", size: 18)!,
                NSParagraphStyleAttributeName: multitudeDescParaStyle
            ])
        

        detailScrollView.addSubview(relayPlayCardView)
        detailScrollView.addSubview(multitudeCardView)
        self.containerView.addSubview(self.imageScrollView)
        self.containerView.addSubview(self.detailScrollView)
        self.view .addSubview(containerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        println(scrollView.contentOffset.x)
        if scrollView.contentOffset.x > 130 {
            var offset = (detailScrollView.frame.size.width / (imageScrollView.frame.size.width - 130)) * scrollView.contentOffset.x
            detailScrollView.setContentOffset(CGPointMake(offset - 130, 0), animated: false)
        }  else if scrollView.contentOffset.x <= -1 {
            scrollView.scrollEnabled = false
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            scrollView.scrollEnabled = true
        }

    }
}