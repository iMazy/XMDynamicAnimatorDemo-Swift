//
//  SnapBehaviorViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/18.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class SnapBehaviorViewController: XMBaseViewController {

    var snapBehavior: UISnapBehavior? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UISnapBehavior 将UIView通过动画吸附到某个点上
    }
    
    override func tapAction(sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: view)
        snapBehavior = UISnapBehavior.init(item: catImageView, snapTo: tapPoint)
        snapBehavior?.damping = 0.5 // 剧列程度
        animator?.addBehavior(snapBehavior!)
    }
    
    override func panAction(sender: UIPanGestureRecognizer) {
        let panPoint = sender.location(in: view)
        if sender.state == UIGestureRecognizerState.began || sender.state == UIGestureRecognizerState.cancelled {
            animator?.removeAllBehaviors()
        }
        if sender.state == UIGestureRecognizerState.ended {
            dealTheEdge(point: panPoint)
        }
        if sender.state == UIGestureRecognizerState.changed {
            catImageView.center = panPoint
        }
    }

    func dealTheEdge(point:CGPoint) {
        let size = view.bounds.size
        let lead = point.x + 64
        let tail = size.width - point.x
        let bottom = size.height - point.y
        
        let edge = catImageView.frame.size.width/2
        
        var newPoint:CGPoint? = nil
        
        if lead < tail {
            if lead < bottom {
                newPoint = CGPoint.init(x: edge, y: point.y)
            } else {
                newPoint = CGPoint.init(x: point.x, y: size.height - edge)
            }
        } else {
            if tail < bottom {
                newPoint = CGPoint.init(x: size.width - edge, y: point.y)
            } else {
                newPoint = CGPoint.init(x: point.x, y: size.height - edge)
            }
        }
        // 创建捕捉行为
        let snap = UISnapBehavior.init(item: catImageView, snapTo: newPoint!)
        snap.damping = 0.3
        animator?.addBehavior(snap)
    }
    


}
