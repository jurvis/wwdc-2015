//
//  ContainerViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 15/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIPageViewControllerDataSource, UIScrollViewDelegate {
    
    var personalProjects: [String: PersonalApp]!
    var hackathonProjects: [String: PersonalApp]!
    var companies: [String: Company]!
    var pageViewController: UIPageViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadModel()
        
        let screenRect: CGRect =  UIScreen.mainScreen().bounds
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Vertical, options: nil)
        self.pageViewController?.dataSource = self
        self.pageViewController!.view.frame = self.view.bounds
        self.pageViewController.view.backgroundColor = UIColor.lightOrangeBackgroundColor()
        
        let viewControllerObject: BaseViewController = self.viewControllerAtIndex(0)
        
        let viewControllers: NSArray = [viewControllerObject]
        self.pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        

        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        for view in self.pageViewController.view.subviews {
            if view is UIScrollView {
                let scrollView = view as? UIScrollView
                scrollView!.delegate = self
            }
        }
    }

    
    func viewControllerAtIndex(index: Int) -> BaseViewController {
        let vc : BaseViewController
        switch index {
            case 0:
                vc = HomeViewController()
            case 1:
                let tempVC = PersonalWorkViewController() as PersonalWorkViewController
                let nebuloApp: PersonalApp = personalProjects["Nebulo"]!
                tempVC.app = nebuloApp
                tempVC.imageName = "nebulo_app_phone"
                vc = tempVC
            case 2:
                let tempVC = PersonalWorkViewController() as PersonalWorkViewController
                let exhibitGuideApp: PersonalApp = personalProjects["ExhibitGuide"]!
                tempVC.app = exhibitGuideApp
                tempVC.imageName = "exhibitguide_app_phone"
                vc = tempVC
            case 3:
                let tempVC = HackathonProjectsViewController() as HackathonProjectsViewController
                tempVC.hackathonProjects = self.hackathonProjects
                tempVC.title = "Hackathon Projects"
                vc = tempVC
            case 4:
                let tempVC = WorkExperienceViewController() as WorkExperienceViewController
                tempVC.workExperience = self.companies
                tempVC.title = "Work Experience"
                vc = tempVC
            default:
                vc = BaseViewController()
        }
        vc.indexNumber = index
        
        
        return vc
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let bvc: BaseViewController = viewController as! BaseViewController
        var index: Int = bvc.indexNumber!
        
        if (index == 0) {
            return nil
        }
        
        --index
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            let bvc: BaseViewController = viewController as! BaseViewController
            var index: Int = bvc.indexNumber!
            
            if (index == 6) {
                return nil
            }
            
            ++index
            
            return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 6
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var y = -scrollView.contentOffset.y + self.view.bounds.height
        NSNotificationCenter.defaultCenter().postNotificationName("scrollViewScrolled", object: y)
    }
    
    func loadModel() {
        let nebuloApp: PersonalApp = PersonalApp(title: "Nebulo", withSubtitle: "Beautiful Haze Reports For Singapore", andDescription: "Aiming to create an easy experience for people to check for the current Air Quality data during the haze season, Nebulo allows users to see the relevant information of the current air without browsing through menus to find the important information.\n\nI built a backend in Go that scrapes http://aqicn.org/ for PM2.5 and PSI data and stores it to be accessed by the iPhone app easily.", andAppIcon: UIImage(named: "nebulo_icon")!)
        let exhibitGuideApp: PersonalApp = PersonalApp(title: "ExhibitGuide", withSubtitle: "Exhibits based on context", andDescription: "With the purpose of creating an app that fulfills the feature of existing audio tour systems, ExhibitGuide is an iOS app I've been working on at my current workplace which utilizes iBeacons to track and feed exhibit data to the user's phones.\n\nWith proximity information gathered from the iBeacons, this app allowed me to explore into displaying relevant UI based on the user’s real-world context; an interaction paradigm that I’m very interested in exploring into in my future apps.", andAppIcon: UIImage(named: "exhibitguide_icon")!)
        self.personalProjects = [nebuloApp.title: nebuloApp,
            exhibitGuideApp.title: exhibitGuideApp]
        
        let relayPlayApp: PersonalApp = PersonalApp(title: "RelayPlay", withSubtitle: "SSC AngelHack AppHack 2013 Winner", andDescription: "Using the Bump API, RelayPlay was a project that takes on the challenge of making an app to “digitally engage” the audience during the upcoming 2015 SEA Games in Singapore.\n\nThe solution involves everyone to crowd-write a story. By allowing everyone to contribute two words to a story, each user will then “bump” on the next device to “pass the torch” - creating a digital torch relay that’s both interactive and personal.", andAppIcon: UIImage(named: "relayplay_icon")!)
        let multitudeApp: PersonalApp = PersonalApp(title: "Multitude", withSubtitle: "CodeXtremeApps Hackathon '14 Finalist", andDescription: "In this hackathon project, we used Apple's iBeacon API, to build an app where a commuter will always receive a notification when leaving the train station asking about his/her commute experience.\n\n The app allowed us to create a discrete set of paramenters to solve  fragmented prose and make user feedback meaningful again where each station will receive a \"satisfaction score\".", andAppIcon: UIImage(named: "multitude_icon")!)
        
        self.hackathonProjects = [relayPlayApp.title: relayPlayApp,
            multitudeApp.title: multitudeApp]
        
        
        let carousell: Company = Company(companyName: "Carousell", andCompanyPosition: "Developer Intern", andDateRange: "Nov \'13 - Mar \'14", andJobDescription: "Wrote front-end technologies at Carousell and worked on internal operation tools with Go, Python & SQL.", withCompanyLogo: UIImage(named: "carousell_logo")!)
        let buuuk : Company = Company(companyName: "buUuk", andCompanyPosition: "iOS Intern", andDateRange: "Mar \'15 - May \'15)", andJobDescription: "iOS Developer at buUuk - an app development studio. Developed “ExhibitGuide” as an internal project for clients.", withCompanyLogo: UIImage(named: "buuuk_logo")!)
        self.companies = [carousell.companyName : carousell,
            buuuk.companyName: buuuk]
    }
}
