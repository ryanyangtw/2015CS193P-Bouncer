//
//  BouncerBehavior.swift
//  Bouncer
//
//  Created by Ryan on 2015/5/19.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

import UIKit

class BouncerBehavior: UIDynamicBehavior {
  
  let gravity = UIGravityBehavior()
  
  lazy var collider: UICollisionBehavior = {
    
    let lazilyCreatedCollider = UICollisionBehavior()
    lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
    return lazilyCreatedCollider
    
  }()
  
  lazy var blockBehavior: UIDynamicItemBehavior = {
    
    let lazilyCreatedBlockBehavior = UIDynamicItemBehavior()
    lazilyCreatedBlockBehavior.allowsRotation = true
    lazilyCreatedBlockBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("BouncerBehavior.Elasticity"))
    lazilyCreatedBlockBehavior.friction = 0
    lazilyCreatedBlockBehavior.resistance = 0
    
    // Should remove notification observer some where
    NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification, object: nil, queue: nil) {
      (notification) -> Void in
      
      lazilyCreatedBlockBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("BouncerBehavior.Elasticity"))
    
    }
    
    return lazilyCreatedBlockBehavior
  }()
  
  override init() {
    super.init()
    addChildBehavior(gravity)
    addChildBehavior(collider)
    addChildBehavior(blockBehavior)
  }
  
  func addBlock(block: UIView) {
    dynamicAnimator?.referenceView?.addSubview(block)
    gravity.addItem(block)
    collider.addItem(block)
    blockBehavior.addItem(block)
  }
  
  func removeBlock(block: UIView) {
    gravity.removeItem(block)
    collider.removeItem(block)
    blockBehavior.removeItem(block)
    block.removeFromSuperview()
  }
  
  
   
}
