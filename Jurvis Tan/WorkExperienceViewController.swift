//
//  WorkExperienceViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 16/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class WorkExperienceViewController: BaseViewController {
    var workExperience = [String : Company]()
    
    var titleIcon: UIImageView!
    var titleLabel: UILabel!
    var shortTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect = UIScreen.mainScreen().bounds
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "WhitneyHTF-Bold", size: 32)
        self.titleLabel.textColor = UIColor.greyTextColor()
        self.titleLabel.text = self.title?.uppercaseString
        self.titleLabel.sizeToFit()
        self.titleLabel.frame = CGRectMake(screenRect.size.width - titleLabel.frame.size.width - (screenRect.size.width * 0.095), screenRect.size.height * 0.074, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)
        
        self.titleIcon = UIImageView()
        self.titleIcon.image = UIImage(named: "briefcase_glyph")
        self.titleIcon.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame) - 14 - self.titleIcon.image!.size.width, CGRectGetMidY(self.titleLabel.frame) - (self.titleIcon.image!.size.height / 2), self.titleIcon.image!.size.width, self.titleIcon.image!.size.height)
        
        let shortTitleWidth: CGFloat = screenRect.size.width * 0.635
        self.shortTitleLabel = UILabel(frame: CGRectMake((screenRect.size.width - shortTitleWidth) / 2 , CGRectGetMaxY(self.titleLabel.frame) + 60, shortTitleWidth, 0))
        self.shortTitleLabel.font = UIFont(name: "Mercury-TextG1Roman", size: 32)!
        self.shortTitleLabel.textColor = UIColor.greyTextColor()
        self.shortTitleLabel.numberOfLines = 0
        self.shortTitleLabel.textAlignment = NSTextAlignment.Center
        self.shortTitleLabel.text = "Since learning to code, I’ve had the pleasure of working at these companies."
        self.shortTitleLabel.sizeToFit()
        
        let carousellLogo: UIImageView = UIImageView(image: UIImage(named: "carousell_logo"))
        carousellLogo.frame = CGRectMake(self.shortTitleLabel.frame.origin.x, CGRectGetMaxY(self.shortTitleLabel.frame) + 35, carousellLogo.image!.size.width, carousellLogo.image!.size.height)
        
        
        let carousellCompanyView: CompanyView = self.createViewWithCompanyName("Carousell")
        carousellCompanyView.frame = CGRectMake(CGRectGetMaxX(carousellLogo.frame) + 50, carousellLogo.frame.origin.y , CGRectGetMaxX(self.shortTitleLabel.frame) - (CGRectGetMaxX(carousellLogo.frame) + 50), carousellLogo.frame.size.height)
        
        let buuukLogo: UIImageView = UIImageView(image: UIImage(named: "buuuk_logo"))
        buuukLogo.frame = CGRectMake(self.shortTitleLabel.frame.origin.x, CGRectGetMaxY(carousellLogo.frame) + 60, buuukLogo.image!.size.width, buuukLogo.image!.size.height)
        let buuukCompanyView: CompanyView = self.createViewWithCompanyName("buUuk")

        
        buuukCompanyView.frame = CGRectMake(carousellCompanyView.frame.origin.x, buuukLogo.frame.origin.y, CGRectGetMaxX(self.shortTitleLabel.frame) - carousellCompanyView.frame.origin.x, buuukLogo.frame.size.height)
        
        self.view.addSubview(carousellLogo)
        self.view.addSubview(carousellCompanyView)
        self.view.addSubview(buuukLogo)
        self.view.addSubview(buuukCompanyView)
        self.view.addSubview(self.shortTitleLabel)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.titleIcon)
    
    }
    
    
    func createViewWithCompanyName(name: String) -> CompanyView {
        let newView = CompanyView()
        let company: Company = workExperience[name]!
        
        newView.positionTitleLabel.text = company.position
        newView.companyNameAndDurationLabel.text = company.companyName + " (" + company.dateRange + ")"
        newView.jobDescriptionLabel.attributedText = NSAttributedString(string: company.jobDescription,
            attributes: [
                NSFontAttributeName: UIFont(name: "WhitneyHTF-Book", size: 21)!,
            ])
        
        
        return newView
    }
}
