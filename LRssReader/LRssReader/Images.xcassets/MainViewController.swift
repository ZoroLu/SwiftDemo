//
//  MainViewController.swift
//  LRssReader
//
//  Created by LGQ on 14-7-30.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class MainViewController : UIViewController, MWFeedParserDelegate, UITableViewDelegate
{
    var items = [MWFeedItem]()
    var theDataSource : TableViewDataSource?
    var configCell : ((cell : AnyObject, item : AnyObject) -> ())?
    var ReuseIdentifier : String = "ReuseIdentifier"
    @IBOutlet var tableView : UITableView?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.configCell = {(cell, item) in
            var tableViewCell : UITableViewCell = cell as UITableViewCell
            var data : MWFeedItem = item as MWFeedItem
            tableViewCell.textLabel.text = data.title
            tableViewCell.textLabel.numberOfLines = 0
            
            let projectURL = data.link.componentsSeparatedByString("?")[0]
            let imgURL : NSURL = NSURL(string: projectURL + "/cover_image?style=200x200#")
            tableViewCell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
            tableViewCell.imageView.setImageWithURL(imgURL, placeholderImage: UIImage(named: "logo.jpg"))
        }
        self.theDataSource = TableViewDataSource(items: self.items, configCell: self.configCell!, reuseIdentifier: self.ReuseIdentifier)
        self.tableView!.dataSource = self.theDataSource
        self.tableView!.delegate = self
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier)
        let URL = NSURL(string: "https://www.wantedly.com/projects.xml")
//        let URL = NSURL(string: "http://onevcat.con/rss/")
        let feedParser = MWFeedParser(feedURL: URL)
        feedParser.delegate = self
        feedParser.parse()
    }
    
    // MWFeedParserDeleage
    func feedParserDidStart(parser: MWFeedParser!) {
        SVProgressHUD.show()
        self.items = [MWFeedItem]()
    }
    
    func feedParserDidFinish(parser: MWFeedParser!) {
        SVProgressHUD.dismiss()
        self.theDataSource?.addItems(self.items)
        self.tableView?.reloadData()
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {
        self.title = info.title
    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        self.items.append(item)
//        print(item)
    }
    
    func feedParser(parser: MWFeedParser!, didFailWithError error: NSError!) {
        var alertView : ZRAlertView = ZRAlertView()
        alertView.showError(self, title: "呵呵了", subTitle: "哎呦呦，真是抱歉呀，解析数据的过程呵呵了")
    }
    
    //show about
    @IBAction func about(sender : AnyObject){
        var aboutView : ZRAlertView = ZRAlertView()
        aboutView.showInfo(self, title: "关于", subTitle: "非原创，学习用。\n原创详情见源码AppDelegate")
    }
    
    // UITableViewDelegate
     func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        let item = self.items[indexPath.row] as MWFeedItem
        let con = KINWebBrowserViewController()
        let url = NSURL(string: item.link)
        con.loadURL(url)
        self.navigationController.pushViewController(con, animated: true)
        
    }
    
}