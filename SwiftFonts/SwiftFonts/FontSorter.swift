//
//  FontSorter.swift
//  SwiftFonts
//
//  Created by LGQ on 14-9-4.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import Foundation

public class FontSorter
{
    public init()
    {
    }
    
    public func sortFontNames(array:[String]) -> [String]
    {
        let predicate = {(s1 : String, s2 : String) -> Bool in
            
            let count1 = countElements(s1.componentsSeparatedByString("-"))
            let s1ContainsHyphen = count1 != 1
            
            let count2 = countElements(s2.componentsSeparatedByString("-"))
            let s2ContainsHyphen = count2 != 1
            
            if(s1ContainsHyphen && s2ContainsHyphen){
                return s1 < s2
            }else{
                if !s1ContainsHyphen
                {
                    return true
                }
                if !s2ContainsHyphen
                {
                    return false
                }
            }
            return s1 < s2
        }
        
        return sorted(array,predicate)
    }
}
