//
//  LJRefreshView.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

protocol LJRefreshViewDelegate
{
    func refreshView(refrenshView: LJRefreshView, didClickButton btn: UIButton)
}

class LJRefreshView : UIView
{
    @IBOutlet var button : UIButton!
    @IBOutlet var indicatator : UIActivityIndicatorView!
    @IBAction func buttonClick(sender : UIButton)
    {
       self.delegate.refreshView(self, didClickButton: sender)
    }
    
    var delegate : LJRefreshViewDelegate!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.indicatator!.hidden = true
    }
    
    func startLoading()
    {
        self.button!.setTitle("", forState: .Normal)
        self.indicatator!.hidden = false
        self.indicatator!.startAnimating()
    }
    
    func stopLoading()
    {
        self.button.setTitle("点击加载更多", forState: .Normal)
        self.indicatator!.hidden = true
        self.indicatator!.stopAnimating()
    }
    
}