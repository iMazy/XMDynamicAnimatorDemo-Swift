//
//  PushBehaviorViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/18.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class PushBehaviorViewController: XMBaseViewController {
    
    /** 推动行为 */
    var pushBehavior: UIPushBehavior? = nil
    
    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineWidth = 3.0
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 1.0
        return shapeLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  UIPushBehavior 可以为一个UIView施加一个力的作用，这个力可以是持续的，也可以只是一个冲量。
        //  我们可以指定力的大小，方向和作用点等等信息。
        
        // UIPushBehavior 有pushDirection、magnitude等属性
        catImageView.transform.rotated(by: CGFloat(M_PI_4))
        
    }

    override func panAction(sender: UIPanGestureRecognizer) {
        let panPoint = sender.location(in: view)
        if sender.state == UIGestureRecognizerState.began || sender.state == UIGestureRecognizerState.cancelled {
            animator?.removeAllBehaviors()
            shapeLayer.removeFromSuperlayer()
        }
        if sender.state == UIGestureRecognizerState.changed {
            updateLine(point: panPoint)
        }
        if sender.state == UIGestureRecognizerState.ended {
            fire(point: panPoint)
        }
    }
    
    private func updateLine(point:CGPoint) {
        catImageView.center = point
        let bezierPath = UIBezierPath()
        bezierPath.move(to: point)
        bezierPath.addLine(to: view.center)
        shapeLayer.path = bezierPath.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
    
    private func fire(point: CGPoint) {
        shapeLayer.removeFromSuperlayer()
        
        let origin: CGPoint = view.center
        
        var distance = sqrtf(powf(Float(origin.x-point.x), 2.0) + powf(Float(origin.y-point.y), 2.0))
        let angle = atan2(origin.y-point.y, origin.x-point.x)
        
        distance = max(distance, 10.0)
        
        // icon位置离中心越远拉力越大
        pushBehavior = UIPushBehavior.init(items: [catImageView], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior?.magnitude = CGFloat(distance/40)
        pushBehavior?.angle = angle
        pushBehavior?.active = true
        animator?.addBehavior(pushBehavior!)
        
        // 添加碰撞行为
        let collision: UICollisionBehavior = UICollisionBehavior.init(items: [catImageView])
        collision.collisionMode = UICollisionBehaviorMode.everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
