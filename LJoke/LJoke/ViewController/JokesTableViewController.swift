//
//  JokesTableViewController.swift
//  LJoke
//
//  Created by LGQ on 14-7-18.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

enum JokesTablewViewControllerType : Int
{
    case HotJoke
    case NewJoke
    case TruthJoke
}

class JokesTableViewController : UIViewController ,UITableViewDelegate, LJRefreshViewDelegate,UITableViewDataSource
{

    let identifier = "cell"
    var jokeType : JokesTablewViewControllerType = .HotJoke
    var tableView : UITableView?
    var dataArray = NSMutableArray()
    var page : Int = 1
    var refreshView : LJRefreshView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "imageViewTapped", object: nil)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewTapped:", name: "imageViewTapped", object: nil)
    }
    
    func setupViews()
    {
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.tableView = UITableView(frame: CGRectMake(0, 64, width, height - 49 - 64))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        var nib = UINib(nibName: "LJJokeCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        
        var arr = NSBundle.mainBundle().loadNibNamed("LJRefreshView", owner: self, options: nil) as Array
        self.refreshView = arr[0] as? LJRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView)
    }
    
    func loadData()
    {
        var url = urlStirng()
        self.refreshView!.startLoading()
        LJHttpRequest.requestionURL(url, completionHandler: {
            data in
            if data as NSObject == NSNull()
            {
                UIView.showAlertView("提示", message: "加载失败")
                return
            }
            
            var arr = data["items"] as NSArray
            for a : AnyObject in arr
            {
                self.dataArray.addObject(a)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
        })
    }
    
    
    func urlStirng() -> String
    {
        switch(jokeType)
        {
            case .HotJoke :
                return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
            case .NewJoke :
                return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
            default:
                return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        }
    }
    
    // #pragma mark - Table View data source
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
   
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
       var cell = tableView?.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? LJJokeCell
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        cell!.data = data
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
   
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        return LJJokeCell.cellHeightByData(data)
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        var commentsVC = CommentViewController(nibName: nil, bundle: nil)
        commentsVC.jokeId = data.stringAttributeForKey("id")
        self.navigationController.pushViewController(commentsVC, animated: true)
        
    }
    
    func refreshView(refrenshView: LJRefreshView, didClickButton btn: UIButton)
    {
        loadData()
    }
    
    func imageViewTapped(noti : NSNotification)
    {
        var imageURL = noti.object as String
        var imgVC = ImageViewController(nibName: nil, bundle: nil)
        imgVC.imageURL = imageURL
        self.navigationController.pushViewController(imgVC, animated: true)
    }
    
}
