//
//  DetailsViewController.swift
//  LPM25
//
//  Created by LGQ on 14-7-22.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//
import UIKit

class DetailsViewController : UIViewController
{

    var city : String?
    var url : String?
    
    @IBOutlet var labelCity : UILabel?
    @IBOutlet var labelLevel : UILabel?
    @IBOutlet var labelUptime : UILabel?
    @IBOutlet var labelUnit : UILabel?
    @IBOutlet var labelAqi : UILabel?
    @IBOutlet var labelPm25 : UILabel?
    @IBOutlet var labelPm10 : UILabel?
    @IBOutlet var labelCo : UILabel?
    @IBOutlet var labelNo2 : UILabel?
    @IBOutlet var labelO31 : UILabel?
    @IBOutlet var labelO38 : UILabel?
    @IBOutlet var labelSo2 : UILabel?
    @IBOutlet var labelPollutant : UILabel?
    @IBOutlet var labelAffect : UILabel?
    @IBOutlet var labelAction : UILabel?
    
    @IBOutlet var imageViewAqi : UIImageView?
    @IBOutlet var imageViewPm25 : UIImageView?
    @IBOutlet var imageViewPm10 : UIImageView?
    @IBOutlet var imageViewCo : UIImageView?
    @IBOutlet var imageViewNo2 : UIImageView?
    @IBOutlet var imageViewO31 : UIImageView?
    @IBOutlet var imageViewO38 : UIImageView?
    @IBOutlet var imageViewSo2 : UIImageView?
    
    
    override func viewDidLoad()
    {
        self.title = city
        
        SVProgressHUD.show()
        
        getData()
        
        //设置ImageView 圆角
        setImageView()
    }
    
    @IBAction func back(sender : AnyObject){
    }
    
    func setImageView(){
        setImageViewCornerRadius(self.imageViewAqi!)
        setImageViewCornerRadius(self.imageViewCo!)
        setImageViewCornerRadius(self.imageViewNo2!)
        setImageViewCornerRadius(self.imageViewO31!)
        setImageViewCornerRadius(self.imageViewO38!)
        setImageViewCornerRadius(self.imageViewPm10!)
        setImageViewCornerRadius(self.imageViewPm25!)
        setImageViewCornerRadius(self.imageViewSo2!)
    }
    
    func setImageViewCornerRadius(imageView : UIImageView)
    {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.hidden = false
    }
    
    func getData(){
        
        var url : NSURL = NSURL(string: self.url)
        let request : NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            (response, data, error) -> Void in
            if error? {
                let alertView : UIAlertView = UIAlertView()
                alertView.title = "提示"
                alertView.message = "\(error.localizedDescription)"
                alertView.addButtonWithTitle("确定")
                alertView.show()
            }else {
                self.parseData(data)
                SVProgressHUD.dismiss()
            }
            })
    }
    
    func parseData(data : NSData)
    {
        var doc : TFHpple = TFHpple.hppleWithHTMLData(data, encoding:"UTF8")
        
        var city : TFHppleElement = doc.peekAtSearchWithXPathQuery("//div[@class='city_name']/h2")
        self.labelCity!.text = self.city
        self.labelCity!.text = city.firstChild.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        var level : TFHppleElement = doc.peekAtSearchWithXPathQuery("//div[@class='level']/h4")
        self.labelLevel!.text = level.firstChild.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        var uptime : TFHppleElement = doc.peekAtSearchWithXPathQuery("//div[@class='live_data_time']/p")
        self.labelUptime!.text = uptime.firstChild.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        var unit : TFHppleElement = doc.peekAtSearchWithXPathQuery("//div[@class='live_data_unit']")
        self.labelUnit!.text = unit.firstChild.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        var caption : NSArray = doc.searchWithXPathQuery("//div[@class='span1']/div[@class='caption']")
        var value : NSArray = doc.searchWithXPathQuery("//div[@class='span1']/div[@class='value']")
        var captionStr:[String] = []
        var val:[String] = []
        
        for c : AnyObject in caption{
            captionStr += (c as TFHppleElement).firstChild.content.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        for v: AnyObject in value{
            val += (v as TFHppleElement).firstChild.content.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
        
        self.labelAqi!.text = val[0] + "\n" + captionStr[0]
        self.labelPm25!.text = val[1] + "\n" + captionStr[1]
        self.labelPm10!.text = val[2] + "\n" + captionStr[2]
        self.labelCo!.text = val[3] + "\n" + captionStr[3]
        
        
        self.labelNo2!.text = val[4] + "\n" + captionStr[4]
        self.labelO31!.text = val[5] + "\n" + captionStr[5]
        self.labelO38!.text = val[6] + "\n" + captionStr[6]
        self.labelSo2!.text = val[7] + "\n" + captionStr[7]
        
        var pollutant : String = doc.peekAtSearchWithXPathQuery("//div[@class='primary_pollutant']/p").firstChild.content.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "");
        self.labelPollutant!.text = pollutant
        
        var affect  : String = doc.peekAtSearchWithXPathQuery("//div[@class='affect']/p").firstChild.content.stringByReplacingOccurrencesOfString("\n", withString: "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).stringByReplacingOccurrencesOfString(" ", withString: "")
        self.labelAffect!.text = affect
        
        var action : String = doc.peekAtSearchWithXPathQuery("//div[@class='action']/p").firstChild.content.stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString(" ", withString: "")
        
        self.labelAction!.text = action
    }
}