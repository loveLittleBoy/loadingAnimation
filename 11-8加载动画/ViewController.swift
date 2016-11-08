//
//  ViewController.swift
//  11-8加载动画
//
//  Created by littleKid on 2016/11/8.
//  Copyright © 2016年 littleKid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var loadAnimationV : LoadAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newView = LoadAnimationView.showWithView(view: self.view)
//        self.view.addSubview(loadView)
        self.loadAnimationV = newView
        
        let rightItem = UIBarButtonItem(title: "隐藏", style: UIBarButtonItemStyle.plain, target: self, action: #selector(stopAnimationAction(sender:)))
        
        self.navigationItem.rightBarButtonItem = rightItem
        
        
    }
    
    
    func stopAnimationAction(sender : UIBarButtonItem) {
        let name = sender.title!
        guard name == "显示" else {
        self.loadAnimationV.hideLoadAnimationView()
            sender.title = "显示"
            return
        }
        
        sender.title = "隐藏"
        self.loadAnimationV = LoadAnimationView.showWithView(view: self.view)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

