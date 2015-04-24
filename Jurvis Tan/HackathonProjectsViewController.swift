//
//  HackathonProjectsViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 16/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class HackathonProjectsViewController: BaseViewController {
    let detailTransitioningDelegate: CardDetailPresentationManager = CardDetailPresentationManager()
    
    var hackathonProjects = [String : PersonalApp]()
    var titleView: TitleView!
    var descriptionTextLabel: UILabel!
    var relayPlayAppIcon: UIImageView!
    var multitudeAppIcon: UIImageView!
    var seeMoreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect: CGRect = UIScreen.mainScreen().bounds
        
        var titleIconImage = UIImage(named: "projects_glyph")
        titleView = TitleView(title: title!.uppercaseString, image: titleIconImage!, frame: CGRectMake(0, 0, 200, titleIconImage!.size.height))
        titleView.resizeToFitSubviews()
        titleView.frame.origin = CGPointMake(screenRect.size.width - titleView.frame.size.width - (screenRect.size.width * 0.056), screenRect.size.height * 0.074)
        
        self.descriptionTextLabel = UILabel()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7;
        self.descriptionTextLabel.attributedText = NSAttributedString(string: "Exploring new technologies fuels my passion in app development, hackathons provide the perfect opportunities for me to tinker and discover them.",
            attributes: [
                NSFontAttributeName: UIFont(name: "Mercury-TextG1Roman", size: 32)!,
                NSParagraphStyleAttributeName: paragraphStyle
            ])
        self.descriptionTextLabel.textColor = UIColor.greyTextColor()
        self.descriptionTextLabel.textAlignment = NSTextAlignment.Center

        let maxWidth: CGFloat = screenRect.size.width * 0.664
        let descriptionTextLabelRect = descriptionTextLabel.attributedText.boundingRectWithSize(CGSizeMake(maxWidth, CGFloat.max), options: (NSStringDrawingOptions.UsesFontLeading | NSStringDrawingOptions.UsesLineFragmentOrigin), context:nil)
        self.descriptionTextLabel.numberOfLines = 0
        self.descriptionTextLabel.frame = CGRectMake((screenRect.size.width - maxWidth) / 2, CGRectGetMaxY(self.titleView.frame) + (screenRect.size.height * 0.086), maxWidth, descriptionTextLabelRect.size.height)
        
        
        let appIconYPos: CGFloat = CGRectGetMaxY(self.descriptionTextLabel.frame) + (screenRect.size.height * 0.086)
        self.relayPlayAppIcon = UIImageView()
        self.relayPlayAppIcon.image = UIImage(named: "relayplay_icon")
        self.relayPlayAppIcon.frame = CGRectMake(self.descriptionTextLabel.frame.origin.x + 20, appIconYPos, self.relayPlayAppIcon.image!.size.width, self.relayPlayAppIcon.image!.size.height)
        
        self.multitudeAppIcon = UIImageView()
        self.multitudeAppIcon.image = UIImage(named: "multitude_icon")
        self.multitudeAppIcon.frame = CGRectMake(CGRectGetMaxX(self.descriptionTextLabel.frame) - self.multitudeAppIcon.image!.size.width - 20, appIconYPos, self.multitudeAppIcon.image!.size.width, self.multitudeAppIcon.image!.size.height)
        
        self.seeMoreBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        self.seeMoreBtn.setBackgroundImage(UIImage(named: "see-more-btn"), forState: UIControlState.Normal)
        self.seeMoreBtn.setBackgroundImage(UIImage(named: "see-more-btn-highlighted"), forState: UIControlState.Highlighted)
        self.seeMoreBtn.addTarget(self, action: "seeMore", forControlEvents: UIControlEvents.TouchUpInside)

        self.seeMoreBtn.center = self.descriptionTextLabel.center
        self.seeMoreBtn.frame = CGRectMake((screenRect.size.width - 329 ) / 2, CGRectGetMaxY(self.multitudeAppIcon.frame) + 45, 329, 43)
        
        self.view.addSubview(self.titleView)
        self.view.addSubview(self.descriptionTextLabel)
        self.view.addSubview(self.relayPlayAppIcon)
        self.view.addSubview(self.multitudeAppIcon)
        self.view.addSubview(self.seeMoreBtn)
    }
    
    
    func seeMore() {
        var detailViewController = CardDetailViewController()
        detailViewController.transitioningDelegate = detailTransitioningDelegate
        detailViewController.modalPresentationStyle = .Custom
        detailViewController.hackathonProjects = self.hackathonProjects
        self.presentViewController(detailViewController, animated: true, completion: nil)
    }
}
