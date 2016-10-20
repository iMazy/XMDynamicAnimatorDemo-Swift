//
//  DynamicItemBehaviorController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/18.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class DynamicItemBehaviorController: XMBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func panAction(sender: UIPanGestureRecognizer) {
        // 移除所有的行为
        animator?.removeAllBehaviors()
        // 设置猫视图的 中心点是手势所在的位置
        catImageView.center = sender.location(in: view)
        
        let itemBehavior = UIDynamicItemBehavior.init(items: [catImageView])
        itemBehavior.elasticity = 0.2           // 弹性系数 在0~1之间
        itemBehavior.friction = 1.0             // 摩擦力系数
        itemBehavior.density = 10               // 跟size大小相关，计算物体块的质量。
        itemBehavior.resistance = 10            // 阻力系数
        itemBehavior.allowsRotation = true       // 是否能旋转
        itemBehavior.angularResistance = 0.1    // 旋转阻力
        animator?.addBehavior(itemBehavior)
        
        // 重力行为
        let gravityBehavior = UIGravityBehavior.init(items: [catImageView])
        animator?.addBehavior(gravityBehavior)
        
    }

}
