//
//  Utilities.swift
//  BeFriend
//
//  Created by David Yoo on 6/23/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .Alert, viewController: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    
    alertController.addAction(okAction)
    
    viewController.presentViewController(alertController, animated: true, completion: nil)
}

