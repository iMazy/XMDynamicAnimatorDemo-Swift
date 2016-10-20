//
//  XMBaseViewController.swift
//  TestUIDynamicAnimator_Swift
//
//  Created by TwtMac on 16/10/17.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class XMBaseViewController: UIViewController {
    
    var animator: UIDynamicAnimator? = nil
    
    lazy var backImageView:UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "puff"))
        imageView.frame = self.view.bounds
        return imageView
    }()
    
    lazy var catImageView:UIImageView = {
        let catImage = UIImageView.init(image: UIImage.init(named: "cat"))
        catImage.frame = CGRect(x: 20, y: 84, width: 80, height: 80)
        catImage.isUserInteractionEnabled = true
        return catImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backImageView)
        view.addSubview(catImageView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(sender:)))
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction(sender:)))
        
        view.addGestureRecognizer(pan)
        view.addGestureRecognizer(tap)
        
        animator = UIDynamicAnimator(referenceView:self.view)
        
    }

    func panAction(sender: UIPanGestureRecognizer) {
        
    }
    
    func tapAction(sender: UITapGestureRecognizer) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
