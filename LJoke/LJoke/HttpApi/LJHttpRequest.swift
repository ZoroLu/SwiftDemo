//
//  LJHttpRequest.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import Foundation
import UIKit

class LJHttpRequest : NSObject
{
    init()
    {
        super.init()
    }
    
    class func requestionURL(urlString : String, completionHandler : (data : AnyObject) -> Void)
    {
        var URL = NSURL.URLWithString(urlString)
        var req = NSURLRequest(URL: URL)
        var queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler:
            { response, data, error in
                if error
                {
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            println(error)
                            completionHandler(data : NSNull())
                        })
                }
                else
                {
                    let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers , error: nil) as NSDictionary
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            completionHandler(data: jsonData)
                        })
                }
            })
    }
}
