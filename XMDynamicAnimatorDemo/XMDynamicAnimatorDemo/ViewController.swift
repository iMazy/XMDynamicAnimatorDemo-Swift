//
//  ViewController.swift
//  XMDynamicAnimatorDemo
//
//  Created by TwtMac on 16/10/20.
//  Copyright © 2016年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let identifier = "reuseIdentifier"
    
    var dataSource:[Dictionary<String,String>] =
        [["behavior":"UIGravityBehavior","name":"重力"],
         ["behavior":"UIAttachmentBehavior","name":"连接"],
         ["behavior":"UIAttachmentBehavior","name":"弹簧"],
         ["behavior":"UISnapBehavior","name":"吸附"],
         ["behavior":"UIPushBehavior","name":"推动"],
         ["behavior":"UICollisionBehavior","name":"碰撞"],
         ["behavior":"UIDynamicItemBehavior","name":"动力元素"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "UIDynamicAnimator"
        
        let myTableView = UITableView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain)
        self.view.addSubview(myTableView)
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = UIColor.white
        myTableView.rowHeight = 44
        myTableView.tableFooterView = UIView(frame:CGRect.zero)
        //        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style:.value1, reuseIdentifier: identifier)
        }
        cell!.accessoryType = .disclosureIndicator
        cell!.textLabel?.text = dataSource[indexPath.row]["behavior"]
        cell!.detailTextLabel?.text = dataSource[indexPath.row]["name"]
        return cell!
    }
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let gravityVC = GravityViewController()
            gravityVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(gravityVC, sender: nil)
        case 1:
            let attachmentVC = AttachmentViewController()
            attachmentVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(attachmentVC, sender: nil)
        case 2:
            let attachmentVC = AttachmentViewController()
            attachmentVC.isSpring = true
            attachmentVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(attachmentVC, sender: nil)
        case 3:
            let snapBehaviorVC = SnapBehaviorViewController()
            snapBehaviorVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(snapBehaviorVC, sender: nil)
        case 4:
            let pushBehaviorVC = PushBehaviorViewController()
            pushBehaviorVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(pushBehaviorVC, sender: nil)
        case 5:
            let collisionBehaviorVC = CollisionBehaviorViewController()
            collisionBehaviorVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(collisionBehaviorVC, sender: nil)
        case 6:
            let dynamicItemBehaviorVC = DynamicItemBehaviorController()
            dynamicItemBehaviorVC.title = dataSource[indexPath.row]["name"]
            navigationController?.show(dynamicItemBehaviorVC, sender: nil)
        default: break
            
        }
    }
}


