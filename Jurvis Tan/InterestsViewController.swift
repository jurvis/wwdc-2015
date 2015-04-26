//
//  InterestsViewController.swift
//  Jurvis Tan
//
//  Created by Jurvis Tan on 18/4/15.
//  Copyright (c) 2015 Jurvis Tan. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class InterestsViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    var openSound: SystemSoundID = 0
    var swipeSound: SystemSoundID = 1
    var smallLayout: UICollectionViewFlowLayout!
    var largeLayout: UICollectionViewFlowLayout!
    
    var photoArray: Array<AnyObject> = []
    var titleView: TitleView!
    var titleHeader: UILabel!
    var titleSubtitle: UILabel!
    var photoGallery: UICollectionView?
    var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioEffects()
        let screenRect = UIScreen.mainScreen().bounds

        self.view.backgroundColor = UIColor.greyTextColor()
        
        var titleIconImage = UIImage(named: "interests_glyph")
        titleView = TitleView(title: title!.uppercaseString, image: titleIconImage!, frame: CGRectMake(0, 0, 200, titleIconImage!.size.height))
        titleView.resizeToFitSubviews()
        titleView.titleLabel.textColor = UIColor.lightOrangeBackgroundColor()
        titleView.frame.origin = CGPointMake(screenRect.size.width - titleView.frame.size.width - (screenRect.size.width * 0.056), screenRect.size.height * 0.074)
        
        let titleHeaderWidth: CGFloat = screenRect.size.width * 0.705
        self.titleHeader = UILabel(frame: CGRectMake((screenRect.size.width - titleHeaderWidth) / 2 , CGRectGetMaxY(self.titleView.frame) + 60, titleHeaderWidth, 0))
        self.titleHeader.font = UIFont(name: "WhitneyHTF-SemiBold", size: 32)!
        self.titleHeader.textColor = UIColor.lightOrangeBackgroundColor()
        self.titleHeader.numberOfLines = 0;
        self.titleHeader.textAlignment = NSTextAlignment.Center
        self.titleHeader.text = "On top of writing apps during my free time, I enjoy travelling and telling stories through my photos to keep in touch with my creative side"
        self.titleHeader.sizeToFit()
        
        
        smallLayout = UICollectionViewFlowLayout()
        smallLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        smallLayout.itemSize = CGSize(width: 450, height: 300)
        smallLayout.minimumInteritemSpacing = 14
        smallLayout.sectionInset = UIEdgeInsetsMake(300, 0, 0, 0)
    
        self.photoGallery = UICollectionView(frame: CGRectMake(0, 0, 921.6, 614.4), collectionViewLayout: smallLayout)
        self.photoGallery!.center =  self.view.center
        self.photoGallery!.backgroundColor = UIColor.clearColor()
        self.photoGallery!.dataSource = self
        self.photoGallery!.delegate = self
        self.photoGallery!.showsHorizontalScrollIndicator = false
        self.photoGallery!.registerClass(PhotoViewCell.self, forCellWithReuseIdentifier: "PhotoViewCell")

        
        largeLayout = UICollectionViewFlowLayout()
        largeLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        largeLayout.itemSize = self.photoGallery!.frame.size
        largeLayout.minimumInteritemSpacing = 14
        
        self.titleSubtitle = UILabel()
        self.titleSubtitle.text = "here are some of my photos"
        self.titleSubtitle.font = UIFont(name: "WhitneyHTF-Book", size: 32)!
        self.titleSubtitle.textColor = UIColor.lightOrangeBackgroundColor()
        self.titleSubtitle.sizeToFit()
        self.titleSubtitle.frame = CGRectMake((screenRect.size.width - self.titleSubtitle.frame.size.width) / 2, CGRectGetMaxY(self.titleHeader.frame) + 40, self.titleSubtitle.frame.size.width, self.titleSubtitle.frame.size.height)
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        spinner.frame = CGRectMake(0, 0, 100, 100);
        spinner.center = self.photoGallery!.center
        spinner.alpha = 0.0
    
        self.view.addSubview(self.titleSubtitle)
        self.view.addSubview(self.titleHeader)
        self.view.addSubview(titleView)
        self.view.addSubview(self.photoGallery!)
        self.view.addSubview(spinner)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if photoArray.count == 0 {
            self.getImages()
        }
    }
    
    func setupAudioEffects() {
        let soundPath = NSBundle.mainBundle().pathForResource("Warp Speed", ofType: "wav")
        var url = NSURL.fileURLWithPath(soundPath!)
        AudioServicesCreateSystemSoundID(url as! CFURL, &self.swipeSound)
        
        
        let soundPath1 = NSBundle.mainBundle().pathForResource("Thats It", ofType: "wav")
        var url1 = NSURL.fileURLWithPath(soundPath1!)
        AudioServicesCreateSystemSoundID(url1 as! CFURL, &self.openSound)
    }
    
    func getImages() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.spinner.alpha = 1.0
        }) { (finished) -> Void in
            if finished {
                self.spinner.startAnimating()
            }
        }
        
        
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c3f5f9e2466cc5cd0d4e0992237278c8&photoset_id=72157651966287326&user_id=64901454%40N03&format=json&nojsoncallback=1")
            .responseJSON { (_, _, JSON, error) in
                if (error == nil) {
                    self.photoArray = JSON?.valueForKeyPath("photoset.photo") as! Array
                    self.photoGallery?.reloadData()
                } else {
                    var alert = UIAlertController(title: "Turn On Wifi/Cellular", message: "This app requires data to display some photos correctly!", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    var alertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)

                }
        }
    }
    
// MARK: UICollectionViewDataSourceDelegate Methods
    
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
        
        let url = self.getPhotoUrl(photo, forSize: "b")
        let request = NSURLRequest(URL: url)
        
        cell.imageView.setImageWithUrlRequest(request, placeHolderImage: UIImage(named: "image_placeholder"), success: { (request, response, image) -> Void in
                cell.imageView.image = image
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    cell.alpha = 1.0
                    self.spinner.alpha = 0.0
                })
                self.spinner.stopAnimating()
            
            }, failure: { (request, response, error) -> Void in
            })
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
        var toLayout = self.smallLayout == collectionView.collectionViewLayout ? self.largeLayout : self.smallLayout
        
        AudioServicesPlaySystemSound(self.openSound)
        
        self.photoGallery?.setCollectionViewLayout(toLayout, animated: true, completion: { (finished) -> Void in
            if toLayout == self.largeLayout {
                collectionView.pagingEnabled = true
            } else {
                collectionView.pagingEnabled = false
            }
        })
    }
    
    // MARK: ScrollViewDelegate Methods
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.largeLayout == photoGallery?.collectionViewLayout { // only play sound when cells are expanded
            AudioServicesPlaySystemSound(swipeSound)
        }
    }
    
    func getPhotoUrl(photo: NSDictionary, forSize size: NSString) -> NSURL {
        var requestUrlString: String = String(format:"https://farm%@.staticflickr.com/", photo["farm"]!.stringValue!)
        requestUrlString = requestUrlString.stringByAppendingString(photo["server"] as! String)
        requestUrlString = requestUrlString.stringByAppendingString(String(format: "/%@_%@_%@.jpg", photo["id"] as! String, photo["secret"] as! String, size))
        
        return NSURL(string: requestUrlString)!
    }

}
