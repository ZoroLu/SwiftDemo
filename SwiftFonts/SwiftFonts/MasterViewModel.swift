//
//  MasterViewModel.swift
//  SwiftFonts
//
//  Created by LGQ on 14-9-6.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class MasterViewModel
{
    var familyNames : [String]
    var fonts = [String : [String]]()
    
    init()
    {
        let unsortedFamilyNames = UIFont.familyNames() as [String]
        familyNames = sorted(unsortedFamilyNames)
        
        let sorter = FontSorter()
        for familyName in familyNames
        {
            let unsortedFontNames = UIFont.fontNamesForFamilyName(familyName) as [String]
            fonts[familyName] = sorter.sortFontNames(unsortedFontNames)
        }
    }
    
    func numberOfSections() -> Int
    {
        return countElements(familyNames)
    }
    
    func numberOfRowsInSection(section : Int) -> Int
    {
        let key = familyNames[section]
        let array = fonts[key]!
        return countElements(array)
    }
    
    func titleAtIndexPath(indexPath : NSIndexPath) -> String
    {
        let key = familyNames[indexPath.section]
        let array = fonts[key]
        return array![indexPath.row]
    }
    
}