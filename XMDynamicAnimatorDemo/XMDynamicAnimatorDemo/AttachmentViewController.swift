//
//  AttachmentViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/17.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class AttachmentViewController: XMBaseViewController {

    var isSpring:Bool = false
    
    private lazy var dotView:UIView = {
        let view = UIView()
        view.frame = CGRect(x:0,y:0,width:10,height:10)
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.init(colorLiteralRed: 220/255.0, green: 206/255.0, blue: 200/255.0, alpha: 1.0).cgColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    var attachBehavior: UIAttachmentBehavior? = nil
    
    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 1.0
        return shapeLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dotView.center = CGPoint.init(x: catImageView.center.x-20, y: 8)
        catImageView.addSubview(dotView)
        // 设置观察者，在手指离开以后继续画线
        catImageView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)
        
        // 添加重力行为
        let gravityBehavior = UIGravityBehavior.init(items: [catImageView])
        animator?.addBehavior(gravityBehavior)
        
        // 吸附行为
        attachBehavior = UIAttachmentBehavior(item: catImageView, offsetFromCenter: UIOffsetMake(0, 0), attachedToAnchor: CGPoint(x:view.bounds.size.width/2,y:120))
        
        attachBehavior?.length = isSpring ? 60 : 120
        // 弹簧效果
        attachBehavior?.damping = 0.1
        attachBehavior?.frequency = isSpring ? 0.6 : 0
        animator?.addBehavior(attachBehavior!)
        
        // 碰撞
        let collision = UICollisionBehavior.init(items: [catImageView])
        collision.collisionMode = UICollisionBehaviorMode.everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
    }
    
    // 平移手势
    override func panAction(sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        attachBehavior!.anchorPoint = point
    }
    
    // 添加观察者
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateLine()
    }
    
    // 更新线条
    func updateLine() {
        
        view.layer.addSublayer(shapeLayer)
        
        let point = view.convert(dotView.center, from: catImageView)
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: attachBehavior!.anchorPoint)
        bezierPath.addLine(to: point)
        shapeLayer.path = bezierPath.cgPath
    }
    
    // 释放观察者
    deinit {
        catImageView.removeObserver(self, forKeyPath: "center")
    }

}
