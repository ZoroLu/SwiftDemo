//
//  ViewController.swift
//  CustomSliderDemo
//
//  Created by LGQ on 14-9-7.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let rangeSlider = RangeSlider(frame: CGRectZero)
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        
        //在这个自定义控件中使用的值改变通知方式是 target-action，因此这里需要添加事件订阅
        //观察值变化有多种方法，但是为了和 UIKit 类似，建议选择 target-action 或者 delegate,两个怎么选择根据情况
        rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        
        //test case
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
//        dispatch_after(time, dispatch_get_main_queue(), {
//            self.rangeSlider.trackHightTintColor = UIColor.redColor()
//            self.rangeSlider.curvaceousness = 1.0
//        })
    }
    
    func rangeSliderValueChanged(rangeSlider : RangeSlider){
        println("Range slider value changed:(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        let margin : CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect( x : margin, y : margin + topLayoutGuide.length, width : width, height : 31.0)
    }


}

