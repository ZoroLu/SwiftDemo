//
//  MainViewController.swift
//  LPM25
//
//  Created by LGQ on 14-7-22.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class MainViewController : UITableViewController
{
    let cellIdentifier = "cellIdentifier"
    
    var indexSet : Array<String>?
    var citiesSet : Array<Array<String>>?
    var dataManager : DataManager?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataManager = DataManager()
        indexSet = dataManager?.getIndexSet()
        citiesSet = dataManager?.getCitiesSet()
        tableView.reloadData()
    }
    
    @IBAction func about(sender : AnyObject)
    {
        ZRAlertView().showInfo(self, title: "关于", subTitle: "非本人原作，数据源于pm2.5,学习用，勿商用！\n原作github:https://github.com/sxyx2008/Swift-PM25")
    }
    
    // #pragma mark -UITableViewDataSource
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : UITableViewCell = tableView!.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        if cell == nil
        {
           cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel.text = citiesSet?[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return citiesSet![section].count
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView!) -> [AnyObject]!
    {
        return indexSet
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return indexSet!.count
    }
    
    // #parama mark -UITableViewDelegate
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String!
    {
        return indexSet?[section]
    }
    
    //
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if segue.identifier == "Details"
        {
            if segue.destinationViewController is DetailsViewController
            {
                var detailsViewController : DetailsViewController = segue.destinationViewController as DetailsViewController
                var city = citiesSet?[self.tableView.indexPathForSelectedRow().section][self.tableView.indexPathForSelectedRow().row] as String
                detailsViewController.city = city
                detailsViewController.url = dataManager?.getCityUrl(city)
            }
        }
    }
    
}