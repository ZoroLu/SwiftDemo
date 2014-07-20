//
//  LJJokeCell.swift
//  LJoke
//
//  Created by LGQ on 14-7-19.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class LJJokeCell : UITableViewCell
{
    @IBOutlet var avatarView : UIImageView?
    @IBOutlet var pictureView : UIImageView?
    @IBOutlet var nickLable : UILabel?
    @IBOutlet var contentLabel : UILabel?
    @IBOutlet var likeLabel : UILabel?
    @IBOutlet var dislikeLabel : UILabel?
    @IBOutlet var commentLabel : UILabel?
    @IBOutlet var bottomView : UIView?
    var largeImageURL : String = ""
    var data :NSDictionary!
    
    @IBAction func shareBtnClicked()
    {
    
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.selectionStyle = .None
        
        var tap = UITapGestureRecognizer(target: self, action: "imageViewTapped:")
        self.pictureView!.addGestureRecognizer(tap)
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
            self.nickLable!.text = userDict["login"] as NSString
            
            var icon : AnyObject! = userDict["icon"]
            if icon as NSObject != NSNull()
            {
                var userIcon = icon as String
                var userId = userDict["id"] as NSString
                var prefixUserId = userId.substringToIndex(3)
                var userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL, placeHolder: UIImage(named: "avatar.jpg"))
            }
            else
            {
                self.avatarView!.image = UIImage(named: "avatar.jpg")
            }
        }
        else
        {
            self.nickLable!.text = "匿名"
            self.avatarView!.image = UIImage(named: "avatar.jpg")
        }
        
        var content = self.data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17, width: 300)
        
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        
        var imgSrc = self.data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            self.pictureView!.hidden = true
            self.bottomView!.setY(self.contentLabel!.bottom())
        }
        else
        {
            var imageId = self.data.stringAttributeForKey("id") as NSString
            var prefixImageId = imageId.substringToIndex(4)
            var imageURL = "http://pic.moumentei.com/system/pictures/\(prefixImageId)/\(imageId)/small/\(imgSrc)"
            self.pictureView!.setImage(imageURL, placeHolder: UIImage(named: "avatar.jpg"))
            self.largeImageURL = "http://pic.moumentei.com/system/pictures/pictures/\(prefixImageId)/\(imageId)/medium/\(imgSrc)"
            self.pictureView!.setY(self.contentLabel!.bottom() + 5)
            self.bottomView!.setY(self.pictureView!.bottom())
        }
        
        var votes : AnyObject! = self.data["votes"]
        if votes as NSObject == NSNull()
        {
            self.likeLabel!.text = "顶(0)"
            self.dislikeLabel!.text = "踩(0)"
        }
        else
        {
            var votesDict = votes as NSDictionary
            var like = votesDict.stringAttributeForKey("up") as String
            var dislike = votesDict.stringAttributeForKey("down") as String
            self.likeLabel!.text = "顶(\(like))"
            self.dislikeLabel!.text = "踩(\(dislike))"
        }
        
        var commentCount = self.data.stringAttributeForKey("comments_count") as String
        self.commentLabel!.text = "评论(\(commentCount))"
    }
    
    class func cellHeightByData(data : NSDictionary) -> CGFloat
    {
       var content = data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17, width: 300)
        var imgSrc = data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            return 59.0 + height + 40.0
        }
        return 59.0 + height + 5.0 + 112.0 + 40.0
    }
    
    func imageViewTapped(sender : UITapGestureRecognizer)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("imageViewTapped", object : self.largeImageURL)
    }
}
