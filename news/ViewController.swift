//
//  ViewController.swift
//  news
//
//  Created by kazan on 2015/05/18.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController,CAPSPageMenuDelegate {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RSS Reader"
        
        var controllerArray : [UIViewController] = []
        
        var feedArray: [ Dictionary<String, String!> ] =
        [
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/computer/rss.xml&num=10" ,
                "title" : "コンピュータ"
            ],
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/world/rss.xml&num=10" ,
                "title" : "海外"
            ],
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/local/rss.xml&num=10" ,
                "title" : "地域"
            ]
        ]
        
        for feed in feedArray {
            
            var feedController = FeedTableViewController()
            feedController.link = feed["link"]!
            feedController.parent = self
            feedController.title = feed["title"]!
            controllerArray.append(feedController)
            
        }
        
        var parameters: [String: AnyObject] = [
            "menuItemSeparatorWidth": 4.3,
            "useMenuLikeSegmentedControl": true,
            "menuItemSeparatorPercentageHeight": 0.1,
            "scrollMenuBackgroundColor": UIColor.grayColor(),
            "selectionIndicatorColor": UIColor.blackColor()
        ]
        
        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        let naviheight = self.navigationController!.navigationBar.frame.size.height
        let y_position = naviheight + statusBarHeight
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, y_position, self.view.frame.width, self.view.frame.height - y_position), options: parameters)
        
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

