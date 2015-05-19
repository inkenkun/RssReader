//
//  DetailViewController.swift
//  news
//
//  Created by kazan on 2015/05/18.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: TOWebViewController {
    
    
    var webview: UIWebView = UIWebView()
    var entry : Dictionary<String, JSON> = [:]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.webview.frame = self.view.bounds
        self.webview.delegate = self;
        self.view.addSubview(self.webview)
        
        var url = NSURL(string: self.entry["link"]!.string!)
        var request = NSURLRequest(URL: url!)
        
        SVProgressHUD.show()
        self.webview.loadRequest(request)
        
    }
    
}

extension DetailViewController : UIWebViewDelegate {
    
    override func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
    }
    
    override func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
    }
    
}