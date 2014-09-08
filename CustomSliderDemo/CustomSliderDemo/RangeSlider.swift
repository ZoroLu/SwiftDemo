//
//  RangeSlider.swift
//  CustomSliderDemo
//
//  Created by LGQ on 14-9-7.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {

    var minimumValue : Double = 0.0 {
        didSet{
            updateLayerFrames()
        }
    }
    var maxinumValue : Double = 1.0 {
        didSet{
            updateLayerFrames()
        }
    }
    var lowerValue : Double = 0.2{
        didSet{
            updateLayerFrames()
        }
    }
    var upperValue : Double = 0.8{
        didSet{
            updateLayerFrames()
        }
    }
    
    let trackLayer = RangeSliderTrackLayer()
    let lowerThumLayer = RangeSliderThumbLayer()
    let upperThumLayer = RangeSliderThumbLayer()
    
    var previousLocation  = CGPoint()
    
    var thumbWidth : CGFloat{
        return CGFloat(bounds.height)
    }
    
    var trackTintColor : UIColor = UIColor(white: 0.9, alpha: 1.0){
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    var trackHightTintColor : UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0){
        didSet{
            trackLayer.setNeedsDisplay()
        }
    }
    var thumbTintColor : UIColor = UIColor.whiteColor() {
        didSet{
            lowerThumLayer.setNeedsDisplay()
            upperThumLayer.setNeedsDisplay()
        }
    }
    
    var curvaceousness : CGFloat = 1.0{
        didSet{
            trackLayer.setNeedsDisplay()
            lowerThumLayer.setNeedsDisplay()
            upperThumLayer.setNeedsDisplay()
        }
    }
    
    override init(frame : CGRect){
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(trackLayer)
        
        
        upperThumLayer.rangeSlider = self
        upperThumLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(upperThumLayer)
        
        lowerThumLayer.rangeSlider = self
        lowerThumLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(lowerThumLayer)
        
        updateLayerFrames()
    }
    
    required init(coder : NSCoder){
        super.init(coder : coder)
    }
    
    func updateLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.rectByInsetting(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        lowerThumLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumLayer.setNeedsDisplay()
        
        CATransaction.commit()
        
    }
    
    func positionForValue(value : Double) -> Double{
        let widthDouble = Double(thumbWidth)
        return Double(bounds.width - thumbWidth) * (value - minimumValue) / (maxinumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    //对属性观察
    override var frame : CGRect{
        didSet{
            updateLayerFrames()
        }
    }
    
    //触摸跟踪，UIControl 的回调
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        previousLocation = touch.locationInView(self)
        
        if lowerThumLayer.frame.contains(previousLocation){
            lowerThumLayer.highlighted = true
        } else if upperThumLayer.frame.contains(previousLocation){
            upperThumLayer.highlighted = true
        }
        return lowerThumLayer.highlighted || upperThumLayer.highlighted
    }
    
    func boundValue(value : Double, toLowerValue lowerValue : Double, upperValue : Double) -> Double{
        return min(max(value,lowerValue),upperValue)
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let location = touch.locationInView(self)
        
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maxinumValue - minimumValue) * deltaLocation / Double(bounds.width - bounds.height)
        
        previousLocation = location
        
        if lowerThumLayer.highlighted{
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumLayer.highlighted{
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maxinumValue)
        }
        
       
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
       lowerThumLayer.highlighted = false
        upperThumLayer.highlighted = false
    }
}
