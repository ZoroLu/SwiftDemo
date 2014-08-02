//
//  TableViewDataSource.swift
//  LRssReader
//
//  Created by LGQ on 14-7-31.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//
import UIKit

class TableViewDataSource : NSObject, UITableViewDataSource
{
    var items : [MWFeedItem]
    var configCell : (cell : AnyObject, item : AnyObject) -> ()
    var reuseIdentifier : String = "reuseIdentifier"
    
    init(items : [MWFeedItem], configCell : (cell : AnyObject, item : AnyObject)->(), reuseIdentifier : String ){
        self.items = items
        self.configCell = configCell
        self.reuseIdentifier = reuseIdentifier
    }
    
    func setItems(items : [MWFeedItem]) ->(){
        self.items = items
    }
    
    func addItem(exItem : MWFeedItem) -> (){
        self.items.append(exItem)
    }
    
    //TODO 没有一次全部加的接口了？？？找不到呀
    func addItems(exItems : [MWFeedItem]) -> (){
        for item in exItems {
            addItem(item)
        }
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        if cell ==  nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: self.reuseIdentifier)
        }
        self.configCell(cell: cell, item: self.items[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
}