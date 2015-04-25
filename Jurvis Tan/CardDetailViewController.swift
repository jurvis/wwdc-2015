//
//  CardDetailViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 17/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit
import AVFoundation

class CardDetailViewController: UIViewController, UIScrollViewDelegate {
    var swipeSound: SystemSoundID = 0
    var hackathonProjects : [String : PersonalApp]!
    
    var pageControl: UIPageControl!
    var containerView: UIView!
    var detailScrollView: UIScrollView!
    var imageScrollView: UIScrollView!
    var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAudioEffects()

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
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.addSubview(relayPlayHeroImageView)
        imageScrollView.addSubview(multitudeHeroImageView)
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, CGRectGetMaxY(imageScrollView.frame) - 20, imageScrollView.frame.size.width, 20))
        self.pageControl.numberOfPages = Int(imageScrollView.contentSize.width / imageScrollView.frame.size.width)
        
        let detailScrollViewRect: CGRect = CGRectMake(0, imageScrollRect.height, cardViewSize.width, cardViewSize.height - CGRectGetMaxY(imageScrollRect))
        detailScrollView = UIScrollView(frame: detailScrollViewRect)
        detailScrollView.contentSize = CGSizeMake(cardViewSize.width * 2, detailScrollViewRect.height)
        detailScrollView.pagingEnabled = true
        detailScrollView.scrollEnabled = false
       
        var relayPlayCardView: HackathonCard = HackathonCard(frame: CGRectMake(0, 15, cardViewSize.width, detailScrollView.bounds.size.height))
        relayPlayCardView.titleLabel.text = hackathonProjects["RelayPlay"]?.subtitle
        
        let relayPlayDescParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        relayPlayDescParaStyle.lineSpacing = 5;
        relayPlayCardView.descriptionTextView.attributedText = NSAttributedString(string: hackathonProjects["RelayPlay"]!.appDescription!,
            attributes: [
                NSFontAttributeName: UIFont(name: "Mercury-TextG1Roman", size: 18)!,
                NSParagraphStyleAttributeName: relayPlayDescParaStyle
            ])
        
        var multitudeCardView: HackathonCard = HackathonCard(frame: CGRectMake(CGRectGetMaxX(relayPlayCardView.frame), 15, cardViewSize.width, detailScrollView.bounds.size.height))
        multitudeCardView.titleLabel.text = hackathonProjects["Multitude"]?.subtitle

        let multitudeDescParaStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        multitudeDescParaStyle.lineSpacing = 5;
        multitudeCardView.descriptionTextView.attributedText = NSAttributedString(string: hackathonProjects["Multitude"]!.appDescription!,
            attributes: [
                NSFontAttributeName: UIFont(name: "Mercury-TextG1Roman", size: 18)!,
                NSParagraphStyleAttributeName: multitudeDescParaStyle
            ])
        
        
        closeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        closeButton.setImage(UIImage(named: "close_btn"), forState: UIControlState.Normal)
        closeButton.setImage(UIImage(named: "close_btn_selected"), forState: UIControlState.Highlighted)
        closeButton.addTarget(self, action: "closeDetail", forControlEvents: UIControlEvents.TouchUpInside)
        closeButton.frame = CGRectMake(CGRectGetMaxX(containerView.frame) - 25 - 34, CGRectGetMinY(containerView.frame) + 25, 34, 34)
        
        detailScrollView.addSubview(relayPlayCardView)
        detailScrollView.addSubview(multitudeCardView)
        self.containerView.addSubview(self.imageScrollView)
        self.containerView.addSubview(self.detailScrollView)
        self.containerView.addSubview(self.pageControl)
        self.containerView.addSubview(self.closeButton)
        self.view .addSubview(containerView)
    }
    
    func setUpAudioEffects() {
        let soundPath = NSBundle.mainBundle().pathForResource("Warp Speed", ofType: "wav")
        var url = NSURL.fileURLWithPath(soundPath!)
        AudioServicesCreateSystemSoundID(url as! CFURL, &self.swipeSound)
    }
    
    func closeDetail() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var pageNumber = ceil(scrollView.contentOffset.x / (scrollView.frame.size.width))
        self.pageControl.currentPage = Int(pageNumber)
    }

    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        AudioServicesPlaySystemSound(swipeSound)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= 130 {
            var offset = ((imageScrollView.frame.size.width + 130.0) / detailScrollView.frame.size.width ) * imageScrollView.contentOffset.x
            detailScrollView.setContentOffset(CGPointMake(offset - 130, 0), animated: false)
        } else if scrollView.contentOffset.x < 130 {
            self.detailScrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        }

    }
}