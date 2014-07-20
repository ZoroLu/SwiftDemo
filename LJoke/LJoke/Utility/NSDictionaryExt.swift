//
//  NSDictionaryExt.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import Foundation

extension NSDictionary
{
    func stringAttributeForKey(key : String) -> String
    {
        var obj : AnyObject! = self[key]
        if obj as NSObject == NSNull()
        {
            return ""
        }
        if obj.isKindOfClass(NSNumber)
        {
            var num = obj as NSNumber
           return num.stringValue
        }
        return obj as String
    }
}
