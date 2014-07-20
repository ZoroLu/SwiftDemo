//
//  LJImageZoomingView.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class LJImageZoomingView : UIScrollView, UIScrollViewDelegate
{
    var imageVIew : UIImageView?
    var imageURL : String!
    let placeHolder : UIImage = UIImage(named: "avatar.jpg")
    
    init(frame : CGRect)
    {
        super.init(frame: frame)
        
        self.delegate = self
        
        self.imageVIew = UIImageView(frame: self.bounds)
        self.imageVIew!.contentMode = .ScaleAspectFit
        self.addSubview(self.imageVIew)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = UIColor.clearColor()
        self.minimumZoomScale = 1
        self.maximumZoomScale = 3
        
        var doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped:")
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func doubleTapped(sender : UITapGestureRecognizer)
    {
        if self.zoomScale > 1.0
        {
            self.setZoomScale(1.0, animated: true)
        }
        else
        {
            var point = sender.locationInView(self)
            self.zoomToRect(CGRectMake(point.x - 50, point.y - 50, 100, 100), animated: true)
        }
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView!
    {
        return self.imageVIew!
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.imageVIew!.setImage(self.imageURL, placeHolder: placeHolder)
    }
}