//
//  NSStringExt.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func stringHeightWith(fontSize : CGFloat, width : CGFloat) -> CGFloat
    {
        var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(width, CGFLOAT_MAX)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping
        var attributes = [NSFontAttributeName : font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var text = self as NSString
        var rect = text.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.size.height
    }
    
    func dataStringFromTimestamp(timeStamp : NSString) -> String
    {
        var ts = timeStamp.doubleValue
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        var date = NSDate(timeIntervalSince1970: ts)
        return formatter.stringFromDate(date)
    }
}
