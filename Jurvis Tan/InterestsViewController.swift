//
//  InterestsViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 18/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit
import Alamofire

class InterestsViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photoArray: Array<AnyObject> = []
    var titleIcon: UIImageView!
    var titleLabel: UILabel!
    var titleHeader: UILabel!
    var titleSubtitle: UILabel!
    var photoGallery: UICollectionView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect = UIScreen.mainScreen().bounds

        self.view.backgroundColor = UIColor.greyTextColor()
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "OpenSans-Extrabold", size: 32)
        self.titleLabel.textColor = UIColor.lightOrangeBackgroundColor()
        self.titleLabel.text = self.title?.uppercaseString
        self.titleLabel.sizeToFit()
        self.titleLabel.frame = CGRectMake(screenRect.size.width - titleLabel.frame.size.width - (screenRect.size.width * 0.095), screenRect.size.height * 0.074, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height)
        
        self.titleIcon = UIImageView()
        self.titleIcon.image = UIImage(named: "interests_glyph")
        self.titleIcon.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame) - 14 - self.titleIcon.image!.size.width, CGRectGetMidY(self.titleLabel.frame) - (self.titleIcon.image!.size.height / 2), self.titleIcon.image!.size.width, self.titleIcon.image!.size.height)
        
        let titleHeaderWidth: CGFloat = screenRect.size.width * 0.705
        self.titleHeader = UILabel(frame: CGRectMake((screenRect.size.width - titleHeaderWidth) / 2 , CGRectGetMaxY(self.titleLabel.frame) + 60, titleHeaderWidth, 0))
        self.titleHeader.font = UIFont(name: "OpenSans-Semibold", size: 32)!
        self.titleHeader.textColor = UIColor.lightOrangeBackgroundColor()
        self.titleHeader.numberOfLines = 0;
        self.titleHeader.textAlignment = NSTextAlignment.Center
        self.titleHeader.text = "On top of writing apps during my free time, I enjoy travelling and telling stories through my photos to keep in touch with my creative side"
        self.titleHeader.sizeToFit()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 14)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.itemSize = CGSize(width: 300, height: 200)
        self.photoGallery = UICollectionView(frame: CGRectMake(self.view.frame.size.width * 0.10 / 2, self.view.frame.size.height * 0.611, self.view.frame.size.width * 0.90, 200), collectionViewLayout: layout)
        self.photoGallery!.backgroundColor = UIColor.clearColor()
        self.photoGallery!.dataSource = self
        self.photoGallery!.delegate = self
        self.photoGallery!.showsHorizontalScrollIndicator = false
        self.photoGallery!.registerClass(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoViewCell")
        
        self.titleSubtitle = UILabel()
        self.titleSubtitle.text = "here are some of my photos"
        self.titleSubtitle.font = UIFont(name: "OpenSans-Light", size: 32)!
        self.titleSubtitle.textColor = UIColor.lightOrangeBackgroundColor()
        self.titleSubtitle.sizeToFit()
        self.titleSubtitle.frame = CGRectMake((screenRect.size.width - self.titleSubtitle.frame.size.width) / 2, (( CGRectGetMaxY(self.titleHeader.frame) + CGRectGetMinY(self.photoGallery!.frame) ) / 2) - self.titleSubtitle.frame.size.height, self.titleSubtitle.frame.size.width, self.titleSubtitle.frame.size.height)
        

    
        self.view.addSubview(self.titleSubtitle)
        self.view.addSubview(self.titleHeader)
        self.view.addSubview(self.photoGallery!)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.titleIcon)
    }
    
    func getImages() {
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c3f5f9e2466cc5cd0d4e0992237278c8&photoset_id=72157651966287326&user_id=64901454%40N03&format=json&nojsoncallback=1")
            .responseJSON { (_, _, JSON, _) in
                self.photoArray = JSON?.valueForKeyPath("photoset.photo") as! Array
                self.photoGallery?.reloadData()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoViewCell", forIndexPath: indexPath) as! PhotoViewCell
        cell.alpha = 0.0
        let photo: NSDictionary = self.photoArray[indexPath.row] as! NSDictionary
        
        let url = self.getPhotoUrl(photo, forSize: "c")
        let request = NSURLRequest(URL: url)
        
        cell.imageView.setImageWithUrlRequest(request, placeHolderImage: UIImage(named: "image_placeholder"), success: { (request, response, image) -> Void in
                cell.imageView.image = image
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    cell.alpha = 1.0
                })
            }, failure: { (request, response, error) -> Void in
                //code
            })
        
        return cell
    }
    
    func getPhotoUrl(photo: NSDictionary, forSize size: NSString) -> NSURL {
        var requestUrlString: String = String(format:"https://farm%@.staticflickr.com/", photo["farm"]!.stringValue!)
        requestUrlString = requestUrlString.stringByAppendingString(photo["server"] as! String)
        requestUrlString = requestUrlString.stringByAppendingString(String(format: "/%@_%@_%@.jpg", photo["id"] as! String, photo["secret"] as! String, size))
        
        return NSURL(string: requestUrlString)!
    }

}
