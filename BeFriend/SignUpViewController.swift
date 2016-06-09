//
//  SignUpViewController.swift
//  BeFriend
//
//  Created by David Yoo on 6/7/16.
//  Copyright © 2016 David Yoo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    enum Error: ErrorType {
        case NoFirstName
        case NoLastName
        case NoUsername
        case NoPassword
        case NoConfirm
        case PasswordMismatch
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

    @IBAction func cancelSignUp() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setup() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            usernameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func createAccount() {
        if checkForBlankFields() == false && checkPasswordMatch() == true {
            showAlert("You're all set! Welcome!")
        }
    }
    
    func checkForBlankFields() -> Bool {
        do {
            if firstNameTextField.text == "" {
                throw Error.NoFirstName
            } else if lastNameTextField.text == "" {
                throw Error.NoLastName
            } else if usernameTextField.text == "" {
                throw Error.NoUsername
            } else if passwordTextField.text == "" {
                throw Error.NoPassword
            } else if confirmTextField.text == "" {
                throw Error.NoConfirm
            }
        }
        catch Error.NoFirstName {
            showAlert("First Name Required")
            return true
        } catch Error.NoLastName {
            showAlert("Last Name Required")
            return true
        } catch Error.NoUsername {
            showAlert("Username Required")
            return true
        } catch Error.NoPassword {
            showAlert("Password Required")
            return true
        } catch Error.NoConfirm {
            showAlert("Please Confirm Password")
            return true
        } catch let error {
            fatalError("\(error)")
        }
        
        return false
    }
    
    func checkPasswordMatch() -> Bool {
        do {
            if passwordTextField.text != confirmTextField.text {
                throw Error.PasswordMismatch
            }
        } catch Error.PasswordMismatch {
            showAlert("Passwords Do Not Match")
            return false
        } catch let error {
            fatalError("\(error)")
        }
        return true
    }
    
    func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
