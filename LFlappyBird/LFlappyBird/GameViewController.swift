//
//  GameViewController.swift
//  LFlappyBird
//
//  Created by LGQ on 14-8-2.
//  Copyright (c) 2014年 LGQ. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode{
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        
        let sceneData = NSData.dataWithContentsOfFile(path, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: nil)
        let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
    
}

class GameViewController: UIViewController {
    
    var skView : SKView!
    var scene : GameScene!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
        
        
        var width = UIScreen.mainScreen().bounds.width
        var height = UIScreen.mainScreen().bounds.height
        self.skView = SKView(frame: CGRectMake(0, 0, width, height))
        self.view.addSubview(self.skView)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
            
        // Sprite Kit applies additional optimizations to improve rendering performance
        skView.ignoresSiblingOrder = true
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = SKSceneScaleMode.AspectFill
            
        skView.presentScene(scene)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        }else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }
}
