//
//  SignUpViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/7/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelSignUp() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
