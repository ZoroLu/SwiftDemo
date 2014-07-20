//
//  ImageViewController.swift
//  LJoke
//
//  Created by LGQ on 14-7-18.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class ImageViewController : UIViewController {

    var imageURL : String = ""
    var imageZoomingView : LJImageZoomingView!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "图片"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews()
    {
        self.imageZoomingView = LJImageZoomingView(frame: self.view.frame)
        self.imageZoomingView.imageURL = self.imageURL
        self.view.addSubview(self.imageZoomingView)
    }
}
