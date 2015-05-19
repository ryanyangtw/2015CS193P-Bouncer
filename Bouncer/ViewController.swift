//
//  ViewController.swift
//  Bouncer
//
//  Created by Ryan on 2015/5/19.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let bouncer = BouncerBehavior()
  lazy var animator: UIDynamicAnimator = { UIDynamicAnimator(referenceView: self.view) }()

  var redBlock: UIView?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    animator.addBehavior(bouncer)
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    if redBlock == nil {
      redBlock = addBlock()
      redBlock?.backgroundColor = UIColor.redColor()
      bouncer.addBlock(redBlock!)
    }
    
    
    // active is wherther it's actively reprting the accelerometer.
    // Available is wheher the hardware is actually avaiable.
    let motionManager = AppDelegate.Motion.Manager
    if motionManager.accelerometerAvailable {
      motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
        (data, error) -> Void in
        
        self.bouncer.gravity.gravityDirection = CGVector(dx: data.acceleration.x, dy: -data.acceleration.y)
        
      }
    }

  }
  
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    
    AppDelegate.Motion.Manager.stopAccelerometerUpdates()
  }
  
  
  
  private struct Constants {
    static let BlockSize = CGSize(width: 40, height: 40)
  }
  
  func addBlock() -> UIView {
    let block = UIView(frame: CGRect(origin: CGPoint.zeroPoint, size: Constants.BlockSize))
    
    block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    view.addSubview(block)
    
    return block
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

