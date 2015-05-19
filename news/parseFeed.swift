//
//  parseFeed.swift
//  news
//
//  Created by kazan on 2015/05/18.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HTMLReader

class parseFeed{
    
    /*
        RSSのJSONをパースする
    */
    func parse (url: String, completion: (([JSON]?, NSError?) -> Void)){
        
        var url = NSURL(string: url)
        
        Alamofire.request(.GET, url!, parameters: nil, encoding: .JSON)
            
            .responseJSON { (request, response, data, error) in
                
                let json = JSON(data!)
                let entries = json["responseData"]["feed"]["entries"].array
                
                completion(entries, error)
        }
    }
    
    
    /*
        URL先の文章と画像を取得
    */
    func getContents (url: String, completion: ((AnyObject, NSError?) -> Void)){
        
        var url = NSURL(string: url)
        var ret : Dictionary<String, String!> = [:]
        
        Alamofire.request(.GET, url!, parameters: nil)
            
            .responseString { (request, response, data, error) in
                
                var content = ""
                let html = HTMLDocument(string: data)
                
                if let ogTags = html.nodesMatchingSelector("meta[property=\"og:description\"]") {
                    for tag in ogTags {
                        content = (tag.attributes?["content"] as? String)!
                    }
                }
                
                var image = ""
                if let imgTags = html.nodesMatchingSelector("img") {
                    for img in imgTags {
                        if(img.attributes?["data-src"] != nil){
                            image = (img.attributes?["data-src"] as? String)!
                        }
                    }
                }
                
                ret = [ "content": content , "image" : image ]
                completion(ret, error)
        }
    }
    
}
