//
//  ViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/6/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nav = self.navigationController?.navigationBar
        nav?.translucent = false
        nav?.shadowImage = UIImage()
        nav?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        nav?.barTintColor = UIColor(red: 234/255, green: 208/255, blue: 45/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

