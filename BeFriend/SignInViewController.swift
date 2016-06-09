//
//  SignInViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/7/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    enum Error: ErrorType {
        case NoUsername
        case NoPassword
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelSignIn() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setup() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginToAccount() {
        if checkForBlankFields() == false {
            showAlert("Welcome Back, \(usernameTextField.text!)!")
        }
    }
    
    func checkForBlankFields() -> Bool {
        do {
            
            if usernameTextField.text == "" {
                throw Error.NoUsername
            } else if passwordTextField.text == "" {
                throw Error.NoPassword
            }
            
        } catch Error.NoUsername {
            showAlert("Please Enter Your Username")
            return true
        } catch Error.NoPassword {
            showAlert("Please Enter Your Password")
            return true
        } catch let error {
            fatalError("\(error)")
        }
        return false
    }

    func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
