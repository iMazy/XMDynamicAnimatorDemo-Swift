//
//  CollisionBehaviorViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/18.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class CollisionBehaviorViewController: XMBaseViewController {

    private lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.transform.rotated(by: CGFloat(-M_PI_4))
        return redView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        redView.frame = CGRect.init(x: 50, y: 300, width: view.bounds.size.width-100, height: 50)
        view.addSubview(redView)
        
        addBehavior()
    }
    
    override func panAction(sender: UIPanGestureRecognizer) {
        // 移除所有行为
        animator?.removeAllBehaviors()
        catImageView.center = sender.location(in: view)
        if sender.state == UIGestureRecognizerState.ended {
            addBehavior()
        }
    }

    // 添加行为
    func addBehavior() {
        // 碰撞行为
        let collisionBehavior = UICollisionBehavior.init(items: [catImageView,redView])
        // 设置边界
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        // 设置代理，监听碰撞事件
        collisionBehavior.collisionDelegate = self
        animator?.addBehavior(collisionBehavior)
        
        // 重力行为
        let gravityBehavior = UIGravityBehavior.init(items: [catImageView])
        animator?.addBehavior(gravityBehavior)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CollisionBehaviorViewController:UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("开始碰撞")
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        print("结束碰撞")
    }
}
