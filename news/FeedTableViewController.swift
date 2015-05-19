//
//  FeedTableViewController.swift
//  news
//
//  Created by kazan on 2015/05/18.
//  Copyright (c) 2015年 inkenkun. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedTableViewController: UITableViewController {
    
    let parse = parseFeed()
    var link: String = String()
    var entries: [JSON] = []
    var parent: UIViewController = UIViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        
        var nib:UINib = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        
        
        parse.parse(self.link, completion: {(data,error) in
            
            self.entries = data!
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        })
        
        self.tableView.addPullToRefresh({ [weak self] in
            
            self?.tableView.reloadData()
            self?.tableView.stopPullToRefresh()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FeedTableViewController : UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        
        cell.title.text = self.entries[indexPath.row]["title"].string
        
        var contents = ""
        var image = ""
        cell.contents.text = ""
        cell.img.image = UIImage(named:"Picture")!
        
        parse.getContents(self.entries[indexPath.row]["link"].string!, completion: { (data, error) in
            
            contents = data["content"] as! String
            cell.contents.text = contents
            
            image = data["image"] as! String
            
            if(image != ""){
                
                self.dispatch_async_global {
                    let url = NSURL(string: image)
                    var err: NSError?;
                    var imageData :NSData = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                    
                    self.dispatch_async_main {
                        cell.img.image = UIImage(data:imageData)!
                        cell.layoutSubviews()
                    }
                }
                
            }else{
                cell.img.image = UIImage(named:"Picture")!
            }
        })
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    func dispatch_async_global(block: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
}

extension FeedTableViewController : UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewController = DetailViewController()
        detailViewController.entry = self.entries[indexPath.row].dictionary!
        parent.navigationController!.pushViewController(detailViewController , animated: true)

    }
    
}
