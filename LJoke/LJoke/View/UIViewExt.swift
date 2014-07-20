//
//  UIViewExt.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    /**
    *  some get method
    *
    */
    func x() -> CGFloat
    {
        return self.frame.origin.x
    }
    
    func right() -> CGFloat
    {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func y() -> CGFloat
    {
        return self.frame.origin.y
    }
    
    func bottom () -> CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    
    func width() -> CGFloat
    {
        return self.frame.size.width
    }
    
    func height() -> CGFloat
    {
        return self.frame.size.height
    }
    
    /**
    *  some set method
    */
    func setX (x : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setY (y : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setRight (right : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setBottom (bottom : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth (width : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight (height : CGFloat)
    {
        var rect : CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    /**
    *  show alert view
    */
    class func showAlertView(title : String , message : String)
    {
        var alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("好")
        alert.show()
    }
    
}
