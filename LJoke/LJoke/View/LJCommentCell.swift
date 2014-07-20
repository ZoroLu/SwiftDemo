//
//  LJCommentCell.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class LJCommentCell : UITableViewCell
{
    @IBOutlet var avatarView : UIImageView?
    @IBOutlet var nicknameLabel : UILabel?
    @IBOutlet var contentLabel : UILabel?
    @IBOutlet var floorLabel : UILabel?
    @IBOutlet var dateLabel : UILabel?
    
    var data : NSDictionary!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        var user : AnyObject! = self.data["user"]
        
        if user as NSObject != NSNull()
        {
            var userDict = user as NSDictionary
            self.nicknameLabel!.text = userDict["login"] as NSString
            
            var icon : AnyObject! = userDict["icon"]
            if icon as NSObject != NSNull()
            {
                var userIcon = icon as NSString
                var userId = userDict["id"] as NSString
                var prefixUserId = userId.substringToIndex(3)
                var userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
            }
            else
            {
                self.avatarView!.image = UIImage(named: "avatar.jpg")
            }
            
            var timeStamp = userDict.stringAttributeForKey("created_at")
            var date = timeStamp.dataStringFromTimestamp(timeStamp)
            self.dateLabel!.text = date
        }
        else
        {
            self.nicknameLabel!.text = "匿名"
            self.avatarView!.image = UIImage(named: "avatar.jpg")
            self.dateLabel!.text = ""
        }
        
        var content = self.data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17, width: 300)
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        self.dateLabel!.setY(self.contentLabel!.bottom())
        var floor = self.data.stringAttributeForKey("floor")
        self.floorLabel!.text = "\(floor)楼"
    }
    
    
    
    class func cellHieghByData(data : NSDictionary) -> CGFloat
    {
        var content = data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17, width: 300)
        return 53.0 + height + 24.0
    }
}
