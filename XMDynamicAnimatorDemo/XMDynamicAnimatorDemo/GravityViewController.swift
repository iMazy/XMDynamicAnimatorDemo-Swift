//
//  GravityViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/17.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class GravityViewController: XMBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func panAction(sender: UIPanGestureRecognizer) {
        // 移除所有的行为
        animator?.removeAllBehaviors()
        // 设置 猫视图的 中心点是手势所在的位置
        catImageView.center = sender.location(in: view)
        //
        if sender.state == UIGestureRecognizerState.ended {
            // 重力
            let gravityBehavior:UIGravityBehavior = UIGravityBehavior.init(items: [catImageView])
            animator?.addBehavior(gravityBehavior)
        }
    }

}
