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
    
    let userHandler = UserHandler()
    
    var user: User?
    
    enum Error: ErrorType {
        case NoUsername
        case NoPassword
        case BadCombo
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startSession" {
            if noBlankFields() && userExists() {
                if let userPageController = segue.destinationViewController as? UserPageController {
                    userPageController.user = user
                }
            }
        }
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
    
    func noBlankFields() -> Bool {
        do {
            
            if usernameTextField.text == "" {
                throw Error.NoUsername
            } else if passwordTextField.text == "" {
                throw Error.NoPassword
            }
            
        } catch Error.NoUsername {
            showAlert("Please Enter Your Username", viewController: self)
            return false
        } catch Error.NoPassword {
            showAlert("Please Enter Your Password", viewController: self)
            return false
        } catch let error {
            fatalError("\(error)")
        }
        return true
    }
    
    func userExists() -> Bool {
        var userExists = false

        user = userHandler.fetchUser(usernameTextField.text!, password: passwordTextField.text!)
        
        if user != nil {
            userExists = true
        }
        
        do {
            if !userExists {
                throw Error.BadCombo
            }
        } catch Error.BadCombo {
            showAlert("Bad Combo", viewController: self)
        } catch let error {
            fatalError("\(error)")
        }
        
        return userExists
    }
}
