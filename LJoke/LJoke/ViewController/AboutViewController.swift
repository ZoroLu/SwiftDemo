//
//  AboutViewController.swift
//  LJoke
//
//  Created by LGQ on 14-7-18.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class AboutViewController : UIViewController{
    
    @IBAction func followAuthor()
    {
        var urlString = "http://weibo.com/yangreal"
        var url = NSURL.URLWithString(urlString)
        UIApplication.sharedApplication().openURL(url)
    }
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    

}