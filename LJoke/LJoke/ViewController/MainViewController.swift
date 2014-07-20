//
//  MainViewController.swift
//  LJoke
//
//  Created by LGQ on 14-7-18.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//
import UIKit

class MainViewController : UITabBarController
{

    var myTabbar : UIView?
    var slider : UIView?
    var tabItemWidth : CGFloat = 80
    let btnBGColor : UIColor = UIColor(red: 125/255.0, green: 236/255.0, blue: 198/255.0, alpha: 1)
    let tabBarBGColor = UIColor(red: 251/255.0, green: 173/255.0, blue: 69/255.0, alpha: 1)
    let titleColor = UIColor(red: 52/255.0, green: 156/255.0, blue: 150/255.0, alpha: 1)
    
    let itemArray = ["最新","热门","真相","关于"]
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "最新"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        initViewControllers()
    }
    
    func setupViews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view!.backgroundColor = UIColor.whiteColor()
        self.tabBar.hidden = true
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.myTabbar = UIView(frame: CGRectMake(0, height - 49, width, 49))
        self.myTabbar!.backgroundColor = tabBarBGColor
        tabItemWidth = width / 4
        self.slider = UIView(frame: CGRectMake(0, 0, tabItemWidth, 49))
        self.slider!.backgroundColor = UIColor.whiteColor()
        
        self.myTabbar!.addSubview(self.slider)
        self.view.addSubview(self.myTabbar)
        
        var count = self.itemArray.count
        for var index = 0; index < count; index++
        {
            var btnLeft : CGFloat = tabItemWidth * CGFloat(index)
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(btnLeft, 0, tabItemWidth, 49)
            button.tag = getTabitemTag(index)
            var title = self.itemArray[index]
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(tabBarBGColor, forState: UIControlState.Selected)
           
            button.addTarget(self, action: "tabBarButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.selected = true
            }
        }
    }
    
    
    /**
    *  tabbar 每个选项的tag  根据索引生成
    *
    *  @param Int  index of the tabbar
    *  @return  tag of the tabbar
    */
    func getTabitemTag (index : Int) -> Int
    {
        return 100 + index
    }
    
    func getTabIndex (tag : Int) -> Int
    {
        return tag - 100
    }
    
    func initViewControllers()
    {
        var vcNew = JokesTableViewController()
        vcNew.jokeType = .NewJoke
        var vcHot = JokesTableViewController()
        vcHot.jokeType = .HotJoke
        var vcTruth = JokesTableViewController()
        vcTruth.jokeType = .TruthJoke
        var vcAbout = AboutViewController(nibName: "AboutViewController", bundle: nil)
        self.viewControllers = [vcNew, vcHot, vcTruth, vcAbout]
    }
    
    func tabBarButtonClick(sender : UIButton)
    {
        var itemTag = sender.tag
        for var i = 0; i < 4; i++ {
            
            var button = self.view.viewWithTag(getTabitemTag(i)) as UIButton
            if button.tag == itemTag
            {
                button.selected = true
            }
            else
            {
                button.selected = false
            }
            
        }
        UIView.animateWithDuration(0.3,
            //这货是闭包  调用类属性方法需要添加 self
            {
                self.slider!.frame = CGRectMake(CGFloat(self.getTabIndex(itemTag)) * self.tabItemWidth , 0, self.tabItemWidth, 49)
            })
        self.title = itemArray[getTabIndex(itemTag)] as String
        self.selectedIndex = getTabIndex(itemTag)
    }
    
}
