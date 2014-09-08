//
//  RangeSliderTrackLayer.swift
//  CustomSliderDemo
//
//  Created by LGQ on 14-9-7.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
  
    weak var rangeSlider : RangeSlider?
    
    override func drawInContext(ctx: CGContext!) {
        if let slider = rangeSlider{
            
            //Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            CGContextAddPath(ctx, path.CGPath)
            
            //Fill the track
            CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
            CGContextAddPath(ctx, path.CGPath)
            CGContextFillPath(ctx)
            
            //Fill the highlighted range
            CGContextSetFillColorWithColor(ctx, slider.trackHightTintColor.CGColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            CGContextFillRect(ctx, rect)
        }
    }
}
