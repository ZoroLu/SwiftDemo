//
//  CommentViewController.swift
//  LJoke
//
//  Created by LGQ on 14-7-18.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class CommentViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, LJRefreshViewDelegate{

    let identifier = "cell"
    var jokeType : JokesTablewViewControllerType = .HotJoke
    var tableView : UITableView?
    var dataArray = NSMutableArray()
    var page : Int = 1
    var refreshView : LJRefreshView?
    var jokeId : String!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "评论"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    func setupViews()
    {
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.tableView = UITableView(frame: CGRectMake(0, 0, width, height))
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        var nib = UINib(nibName: "LJCommentCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
        
        var arr = NSBundle.mainBundle().loadNibNamed("LJRefreshView", owner: self, options: nil)
        self.refreshView = arr[0] as? LJRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView)
    }
    
    func loadData()
    {
        var url = "http://m2.qiushibaike.com/article/\(self.jokeId)/comments?count=20&page=\(self.page)"
        self.refreshView!.startLoading()
        LJHttpRequest.requestionURL(url, completionHandler: {
            data in
            if data as NSObject == NSNull()
            {
                UIView.showAlertView("提示", message: "加载失败")
                return
            }
            
            var arr = data["items"] as NSArray
            if arr.count == 0
            {
                UIView.showAlertView("提示", message: "暂无新评论哦")
                self.tableView!.tableFooterView = nil
            }

            for data : AnyObject in arr
            {
                self.dataArray.addObject(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
            })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell?
    {
        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? LJCommentCell
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        cell!.data = data
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        return LJCommentCell.cellHieghByData(data)
    }
    
    func refreshView(refrenshView: LJRefreshView, didClickButton btn: UIButton)
    {
        loadData()
    }
    
    
    
    
}